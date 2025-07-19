class Loyalty {
  final String customerId;
  final int points;

  Loyalty({
    required this.customerId,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'points': points,
    };
  }

  factory Loyalty.fromMap(Map<String, dynamic> map) {
    return Loyalty(
      customerId: map['customerId'] ?? '',
      points: map['points'] ?? 0,
    );
  }
}
