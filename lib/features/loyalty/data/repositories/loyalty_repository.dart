import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyaltyart/features/loyalty/loyalty_model.dart';

class LoyaltyRepository {
  final _loyaltyCollection = FirebaseFirestore.instance.collection('loyalty');

  Stream<Loyalty?> getLoyalty(String customerId) {
    return _loyaltyCollection.doc(customerId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (snapshot.exists && data != null) {
        return Loyalty.fromMap(data);
      }
      return null;
    });
  }

  Future<void> incrementPoints(String customerId, {int amount = 1}) async {
    final doc = _loyaltyCollection.doc(customerId);
    final snapshot = await doc.get();
    final data = snapshot.data();

    if (snapshot.exists && data != null) {
      final current = Loyalty.fromMap(data);
      final currentPoints = current.points;
      await doc.update({'points': currentPoints + amount});
    } else {
      await doc.set({'customerId': customerId, 'points': amount});
    }
  }
}

