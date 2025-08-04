import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCard extends StatelessWidget {
  final String customerId;

  const QrCard({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final dataToEncode = customerId.trim();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Show this QR code on visit'),
            if (dataToEncode.isNotEmpty)
              QrImageView(data: dataToEncode, size: 200)
            else
              const Text('Invalid customer ID'),
          ],
        ),
      ),
    );
  }
}
