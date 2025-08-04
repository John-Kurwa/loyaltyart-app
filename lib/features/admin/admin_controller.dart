import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminController extends ChangeNotifier {
  double totalRevenue = 0.0;
  int totalBookings = 0;
  int totalLoyaltyScans = 0;
  Map<String, int> topCustomers = {};

  List<BarChartGroupData> revenueBarGroups = [];
  List<FlSpot> bookingsLineSpots = [];
  List<DateTime> bookingDates = [];

  final _paymentsCollection = FirebaseFirestore.instance.collection('payments');
  final _bookingsCollection = FirebaseFirestore.instance.collection('bookings');
  final _loyaltyCollection = FirebaseFirestore.instance.collection('loyalty');

  // ✅ Chart data accessors
  List<BarChartGroupData> get revenueChart => revenueBarGroups;

  List<Map<String, dynamic>> get bookingsChart {
    return List.generate(bookingsLineSpots.length, (index) {
      return {'date': bookingDates[index], 'value': bookingsLineSpots[index].y};
    });
  }

  Future<void> loadAnalytics() async {
    // Total revenue
    final paymentsSnap = await _paymentsCollection.get();
    totalRevenue = paymentsSnap.docs.fold(
      0.0,
      (acc, doc) => acc + (doc['amount'] ?? 0.0),
    );

    // Total bookings
    final bookingsSnap = await _bookingsCollection.get();
    totalBookings = bookingsSnap.size;

    // Total loyalty scans
    final loyaltySnap = await _loyaltyCollection.get();
    totalLoyaltyScans = loyaltySnap.docs.fold(
      0,
      (acc, doc) => acc + ((doc['points'] ?? 0) as int),
    );

    // Top customers
    topCustomers = {
      for (var doc in loyaltySnap.docs)
        if (doc['customerId'] != null) doc['customerId']: doc['points'] ?? 0,
    };

    // ✅ Revenue per month
    Map<String, double> revenuePerMonth = {};
    for (var doc in paymentsSnap.docs) {
      // final date = DateTime.parse(doc['date']);
      final dateString = doc['date'];
      if (dateString == null) continue;
      final date = DateTime.tryParse(dateString);
      if (date == null) continue;
      final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
      revenuePerMonth[monthKey] =
          (revenuePerMonth[monthKey] ?? 0.0) + (doc['amount'] ?? 0.0);
    }
    final sortedMonths = revenuePerMonth.keys.toList()..sort();
    revenueBarGroups = [];
    for (int i = 0; i < sortedMonths.length; i++) {
      final amount = revenuePerMonth[sortedMonths[i]]!;
      revenueBarGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: amount, color: Colors.deepPurple, width: 16),
          ],
        ),
      );
    }

    // ✅ Bookings per day
    Map<String, int> bookingsPerDay = {};
    Map<String, DateTime> dateMap = {};
    for (var doc in bookingsSnap.docs) {
      // final date = DateTime.parse(doc['bookingDate']);
      final dateString = doc['bookingDate'];
      if (dateString == null) continue;
      final date = DateTime.tryParse(dateString);
      if (date == null) continue;
      final dayKey = "${date.year}-${date.month}-${date.day}";
      bookingsPerDay[dayKey] = (bookingsPerDay[dayKey] ?? 0) + 1;
      dateMap[dayKey] = date;
    }
    final sortedDays = bookingsPerDay.keys.toList()..sort();
    bookingsLineSpots = [];
    bookingDates = [];
    for (int i = 0; i < sortedDays.length; i++) {
      final count = bookingsPerDay[sortedDays[i]]!;
      bookingsLineSpots.add(FlSpot(i.toDouble(), count.toDouble()));
      bookingDates.add(dateMap[sortedDays[i]]!);
    }

    notifyListeners();
  }
}
