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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadLoyalty('test_customer_id');
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
            child: const Text(
              'Scan Loyalty QR (Staff)',
              // style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/scanqr');
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(
              'Admin Analytics',
              // style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
          ),
        ],
      ),
    );
  }
}
