class Loyalty {
  final String customerId;
  final int points;

  Loyalty({required this.customerId, required this.points});

  Map<String, dynamic> toMap() {
    return {'customerId': customerId, 'points': points};
  }

  factory Loyalty.fromMap(Map<String, dynamic> map) {
    final customerId = map['customerId'];
    final points = map['points'];

    return Loyalty(
      customerId: customerId is String ? customerId : '',
      points: points is int ? points : 0,
    );
  }
}
