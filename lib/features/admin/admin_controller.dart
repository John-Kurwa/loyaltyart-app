import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenueData {
  final String month;
  final double amount;
  RevenueData(this.month, this.amount);
}

class BookingData {
  final DateTime date;
  final int count;
  BookingData(this.date, this.count);
}

class AdminController extends ChangeNotifier {
  double totalRevenue = 0.0;
  int totalBookings = 0;
  int totalLoyaltyScans = 0;
  Map<String, int> topCustomers = {}; // name and their loyalty points

  List<BarChartGroupData> revenueBarGroups = [];
  List<FlSpot> bookingsLineSpots = [];

  final _paymentsCollection = FirebaseFirestore.instance.collection('payments');
  final _bookingsCollection = FirebaseFirestore.instance.collection('bookings');
  final _loyaltyCollection = FirebaseFirestore.instance.collection('loyalty');

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

    // Total loyalty scans (each loyalty document’s points as count of visits)
    final loyaltySnap = await _loyaltyCollection.get();
    totalLoyaltyScans = loyaltySnap.docs.fold(
      0,
      (acc, doc) => acc + ((doc['points'] ?? 0) as int),
    );

    // Top customers by points
    topCustomers = {
      for (var doc in loyaltySnap.docs)
        doc['customerId']: doc['points'] ?? 0
    };

    // Revenue by month for BarChart
    Map<String, double> revenuePerMonth = {};
    for (var doc in paymentsSnap.docs) {
      final date = DateTime.parse(doc['date']);
      final monthKey = "${date.year}-${date.month}";
      revenuePerMonth[monthKey] = (revenuePerMonth[monthKey] ?? 0.0) + (doc['amount'] ?? 0.0);
    }
    // Sort months for chart
    final sortedMonths = revenuePerMonth.keys.toList()..sort();
    revenueBarGroups = [];
    for (int i = 0; i < sortedMonths.length; i++) {
      final month = sortedMonths[i];
      final amount = revenuePerMonth[month]!;
      revenueBarGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: amount,
              color: Colors.deepPurple,
              width: 16,
            ),
          ],
        ),
      );
    }

    // Bookings by day for LineChart
    Map<String, int> bookingsPerDay = {};
    for (var doc in bookingsSnap.docs) {
      final date = DateTime.parse(doc['bookingDate']);
      final dayKey = "${date.year}-${date.month}-${date.day}";
      bookingsPerDay[dayKey] = (bookingsPerDay[dayKey] ?? 0) + 1;
    }
    // Sort days for chart
    final sortedDays = bookingsPerDay.keys.toList()..sort();
    bookingsLineSpots = [];
    for (int i = 0; i < sortedDays.length; i++) {
      final day = sortedDays[i];
      final count = bookingsPerDay[day]!;
      bookingsLineSpots.add(
        FlSpot(i.toDouble(), count.toDouble()),
      );
    }

    notifyListeners();
  }
}