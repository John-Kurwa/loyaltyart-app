import 'package:flutter/material.dart';
import 'package:loyaltyart/features/bookings/bookings_controller.dart';
import 'package:loyaltyart/features/bookings/presentation/pages/widgets/booking_form.dart';
import 'package:provider/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  bool get isMobile => MediaQuery.of(context).size.width < 600;
  double get screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const BookingForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: controller.bookings.isEmpty
          ? const Center(child: Text('No bookings yet'))
          : ListView.builder(
              itemCount: controller.bookings.length,
              itemBuilder: (context, index) {
                final booking = controller.bookings[index];
                final customerName = booking.customerName.isNotEmpty
                    ? booking.customerName
                    : 'No name';
                final service = booking.service.isNotEmpty
                    ? booking.service
                    : 'Unknown service';
                final phone = booking.phone.isNotEmpty
                    ? booking.phone
                    : 'No phone';

                return ListTile(
                  title: Text(customerName),
                  subtitle: Text(
                    "$service on ${booking.bookingDate.toLocal()}",
                  ),
                  trailing: Text(phone),
                );
              },
            ),
    );
  }
}
