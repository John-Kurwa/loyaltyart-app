import 'package:flutter/material.dart';
import 'package:loyaltyart/features/payments/payments_controller.dart';
import 'package:provider/provider.dart';
import '../widgets/payment_form.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PaymentsController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const PaymentForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: controller.payments.isEmpty
          ? const Center(child: Text('No payments yet'))
          : ListView.builder(
              itemCount: controller.payments.length,
              itemBuilder: (context, index) {
                final payment = controller.payments[index];
                return ListTile(
                  title: Text(payment.customerName),
                  subtitle: Text(
                    '${payment.method} on ${payment.date.toLocal().toString().substring(0, 16)}',
                  ),
                  trailing: Text('KES ${payment.amount.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
