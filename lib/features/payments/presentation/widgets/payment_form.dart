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
  String method = '';

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
              onSaved: (val) => customerName = val ?? '',
              validator: (val) => val!.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSaved: (val) => amount = double.tryParse(val ?? '0') ?? 0,
              validator: (val) => val!.isEmpty ? 'Enter amount' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Payment Method'),
              onSaved: (val) => method = val ?? '',
              validator: (val) => val!.isEmpty ? 'Enter payment method' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Save Payment'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final payment = Payment(
                    id: const Uuid().v4(),
                    customerName: customerName,
                    amount: amount,
                    date: DateTime.now(),
                    method: method,
                  );
                  Provider.of<PaymentsController>(context, listen: false)
                      .addPayment(payment);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
