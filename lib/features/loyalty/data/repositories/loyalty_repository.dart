import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyaltyart/features/loyalty/loyalty_model.dart';
// import 'lib/features/loyalty/loyalty_model.dart';

class LoyaltyRepository {
  final _loyaltyCollection = FirebaseFirestore.instance.collection('loyalty');

  Stream<Loyalty?> getLoyalty(String customerId) {
    return _loyaltyCollection.doc(customerId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return Loyalty.fromMap(snapshot.data()!);
      }
      return null;
    });
  }

  Future<void> incrementPoints(String customerId, {int amount = 1}) async {
    final doc = _loyaltyCollection.doc(customerId);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      final current = Loyalty.fromMap(snapshot.data()!);
      await doc.update({'points': current.points + amount});
    } else {
      await doc.set({'customerId': customerId, 'points': amount});
    }
  }
}
