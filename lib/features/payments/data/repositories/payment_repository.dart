import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyaltyart/features/payments/payments_model.dart';
// import '../features/payments/payments_model.dart';

class PaymentRepository {
  final _paymentCollection = FirebaseFirestore.instance.collection('payments');

  Future<void> addPayment(Payment payment) async {
    await _paymentCollection.doc(payment.id).set(payment.toMap());
  }

  Stream<List<Payment>> getPayments() {
    return _paymentCollection
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Payment.fromMap(doc.data())).toList());
  }
}
