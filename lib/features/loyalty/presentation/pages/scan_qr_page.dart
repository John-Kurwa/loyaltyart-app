import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import '../../loyalty_controller.dart';

class ScanQrPage extends StatelessWidget {
  const ScanQrPage({super.key});

  Future<void> scanQr(BuildContext context) async {
    String scanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.QR);
    
    if (scanResult != '-1') {
      // update loyalty points
      await Provider.of<LoyaltyController>(context, listen: false)
          .addVisit(scanResult);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loyalty points updated for $scanResult')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Loyalty QR')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan QR Code'),
          onPressed: () => scanQr(context),
        ),
      ),
    );
  }
}
