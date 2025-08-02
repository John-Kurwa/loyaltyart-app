import 'package:flutter/material.dart';
import 'package:loyaltyart/features/payments/payments_controller.dart';
import 'package:loyaltyart/features/payments/payments_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String customerName = '';
  double amount = 0.0;
  String method = 'Mpesa';

  final List<String> paymentMethods = ['Mpesa', 'Cash', 'Card', 'PayPal'];

  IconData _getMethodIcon(String method) {
    switch (method) {
      case 'Mpesa':
        return Icons.phone_android;
      case 'Cash':
        return Icons.attach_money;
      case 'Card':
        return Icons.credit_card;
      case 'PayPal':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Customer Name'),
              onSaved: (val) => customerName = val?.trim() ?? '',
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Enter name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSaved: (val) =>
                  amount = double.tryParse(val?.trim() ?? '') ?? 0,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Enter amount';
                }
                final parsed = double.tryParse(val);
                if (parsed == null || parsed <= 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: method,
              decoration: const InputDecoration(labelText: 'Payment Method'),
              items: paymentMethods.map((m) {
                return DropdownMenuItem(
                  value: m,
                  child: Row(
                    children: [
                      Icon(
                        _getMethodIcon(m),
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(m),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => method = val);
                }
              },
              onSaved: (val) => method = val ?? 'Mpesa',
              validator: (val) =>
                  (val == null || val.isEmpty) ? 'Select a payment method' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text(
                'Save Payment',
                // style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final payment = Payment(
                    id: const Uuid().v4(),
                    customerName: customerName,
                    amount: amount,
                    date: DateTime.now(),
                    method: method,
                  );

                  try {
                    await Provider.of<PaymentsController>(context, listen: false)
                        .addPayment(payment);
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving payment: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
