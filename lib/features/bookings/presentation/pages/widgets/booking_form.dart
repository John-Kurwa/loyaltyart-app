import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../bookings_controller.dart';
import '../../../bookings_model.dart';
import 'package:uuid/uuid.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String customerName = '';
  String phone = '';
  String service = '';
  DateTime? bookingDate;

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
              decoration: const InputDecoration(labelText: 'Phone'),
              onSaved: (val) => phone = val ?? '',
              validator: (val) => val!.isEmpty ? 'Enter phone' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Service'),
              onSaved: (val) => service = val ?? '',
              validator: (val) => val!.isEmpty ? 'Enter service' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text(bookingDate == null
                  ? 'Select Date'
                  : bookingDate.toString(),
                  style: TextStyle(color: Colors.white),
                  ), 
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 0)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    bookingDate = picked;
                    }
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text(
                'Save Booking',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (bookingDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a booking date')),
                    );
                    return;
                  }
                  _formKey.currentState!.save();
                  final booking = Booking(
                    id: const Uuid().v4(),
                    customerName: customerName,
                    phone: phone,
                    bookingDate: bookingDate!,
                    service: service,
                  );
                  Provider.of<BookingsController>(context, listen: false)
                      .addBooking(booking);
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
