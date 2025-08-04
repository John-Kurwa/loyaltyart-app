import 'package:flutter/material.dart';
import 'loyalty_model.dart';
import 'data/repositories/loyalty_repository.dart';

class LoyaltyController extends ChangeNotifier {
  final LoyaltyRepository _repo = LoyaltyRepository();
  Loyalty? loyalty;

  void loadLoyalty(String customerId) {
    _repo.getLoyalty(customerId).listen((loyaltyData) {
      loyalty = loyaltyData;
      notifyListeners();
    });
  }

  Future<void> addVisit(String customerId) async {
    await _repo.incrementPoints(customerId);
  }
}
