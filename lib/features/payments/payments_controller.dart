import 'package:flutter/material.dart';
import 'payments_model.dart';
import 'data/repositories/payment_repository.dart';


class PaymentsController extends ChangeNotifier {
  final PaymentRepository _repo = PaymentRepository();

  List<Payment> _payments = [];
  List<Payment> get payments => _payments;

  void loadPayments() {
    _repo.getPayments().listen((event) {
      _payments = event;
      notifyListeners();
    });
  }

  Future<void> addPayment(Payment payment) async {
    await _repo.addPayment(payment);
  }
}

