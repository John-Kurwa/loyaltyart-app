import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../bookings_controller.dart';
import '../../../bookings_model.dart';

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
  DateTime? _bookingDate;

  Future<void> _selectBookingDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _bookingDate = picked;
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final selectedDate = _bookingDate;
    if (selectedDate == null) {
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
      bookingDate: selectedDate,
      service: service,
    );

    Provider.of<BookingsController>(context, listen: false).addBooking(booking);
    Navigator.pop(context);
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
              onSaved: (val) => customerName = val ?? '',
              validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              onSaved: (val) => phone = val ?? '',
              validator: (val) => val == null || val.isEmpty ? 'Enter phone' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Service'),
              onSaved: (val) => service = val ?? '',
              validator: (val) => val == null || val.isEmpty ? 'Enter service' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectBookingDate(context),
              child: Text(
                _bookingDate == null
                    ? 'Select Date'
                    : 'Selected: ${_bookingDate!.toLocal()}'.split(' ')[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: const Text(
                'Save Booking',
                style: TextStyle(color: Colors.white, ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
