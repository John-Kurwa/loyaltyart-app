import 'package:flutter/material.dart';
import 'payments_model.dart';
import 'data/repositories/payment_repository.dart';

class PaymentsController extends ChangeNotifier {
  final PaymentRepository _repo = PaymentRepository();

  List<Payment> _payments = [];
  List<Payment> get payments => _payments;

  void loadPayments() {
    _repo.getPayments().listen(
      (event) {
        _payments = event.toList();
        notifyListeners();
      },
      onError: (error) {
        debugPrint('Error loading payments: $error');
      },
    );
  }

  Future<void> addPayment(Payment payment) async {
    try {
      await _repo.addPayment(payment);
      // Optional: refresh list after adding
      loadPayments();
    } catch (e) {
      debugPrint('Error adding payment: $e');
    }
  }
}
