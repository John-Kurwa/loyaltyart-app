import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCard extends StatelessWidget {
  final String customerId;

  const QrCard({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Show this QR code on visit'),
            QrImageView(
              data: customerId,
              size: 200,
            ),
          ],
        ),
      ),
    );
  }
}
