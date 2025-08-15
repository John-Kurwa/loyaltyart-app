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
      appBar: AppBar(
        title: const Text('Payments'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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

                final customerInitial = (payment.customerName.isNotEmpty)
                    ? payment.customerName[0]
                    : '?';

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(customerInitial)),
                    title: Text(
                      payment.customerName.isNotEmpty
                          ? payment.customerName
                          : 'Unnamed',
                    ),
                    subtitle: Text(
                      '${payment.method} • ${payment.date.toLocal().toString().substring(0, 16)}',
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'KES ${payment.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Completed',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
