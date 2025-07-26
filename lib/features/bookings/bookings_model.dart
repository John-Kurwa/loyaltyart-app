import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String customerName;
  final String phone;
  final DateTime bookingDate;
  final String service;

  Booking({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.bookingDate,
    required this.service,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'phone': phone,
      'bookingDate': bookingDate.toIso8601String(),
      'service': service,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      customerName: map['customerName'] ?? '',
      phone: map['phone'] ?? '',
      bookingDate: _parseDate(map['bookingDate']),
      service: map['service'] ?? '',
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}
