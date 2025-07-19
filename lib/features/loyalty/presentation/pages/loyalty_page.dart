import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../loyalty_controller.dart';
import '../widgets/qr_card.dart';

class LoyaltyPage extends StatelessWidget {
  const LoyaltyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoyaltyController>(context);

    // Load a test user for now
    controller.loadLoyalty('test_customer_id');

    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty Dashboard')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrCard(customerId: 'test_customer_id'),
          const SizedBox(height: 16),
          Text(
            'Points: ${controller.loyalty?.points ?? 0}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            child: const Text('Scan Loyalty QR (Staff)'),
            onPressed: () {
              Navigator.pushNamed(context, '/scanqr');
            },          
          ),
          ElevatedButton(
            child: const Text('Admin Analytics'),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
          ),
        ],
      ),
    );
  }
}
