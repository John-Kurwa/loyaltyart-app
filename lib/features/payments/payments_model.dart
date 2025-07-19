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
      'date': date.toIso8601String(),
      'method': method,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] ?? '',
      customerName: map['customerName'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: DateTime.parse(map['date']),
      method: map['method'] ?? '',
    );
  }
}
