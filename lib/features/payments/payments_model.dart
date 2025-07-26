import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String id;
  final String customerName;
  final double amount;
  final DateTime date;
  final String method;

  Payment({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.method,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'amount': amount,
      'date': date.toIso8601String(), // Save as ISO string for consistency
      'method': method,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    // Handle both Timestamp (Firestore) and String
    DateTime parsedDate;
    if (map['date'] is String) {
      parsedDate = DateTime.tryParse(map['date']) ?? DateTime.now();
    } else if (map['date'] is Timestamp) {
      parsedDate = (map['date'] as Timestamp).toDate();
    } else {
      parsedDate = DateTime.now(); // Fallback if date is null or invalid
    }

    return Payment(
      id: map['id'] as String? ?? '',
      customerName: map['customerName'] as String? ?? '',
      amount: (map['amount'] is num) ? (map['amount'] as num).toDouble() : 0.0,
      date: parsedDate,
      method: map['method'] as String? ?? '',
    );
  }
}
