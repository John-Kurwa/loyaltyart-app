import 'package:flutter/material.dart';
import 'package:loyaltyart/features/bookings/bookings_model.dart';
import 'data/repositories/booking_repository.dart';
import 'package:loyaltyart/core/services/sms_service.dart';

class BookingsController extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;

  void loadBookings() {
    _repository.getBookings().listen((event) {
      _bookings = event;
      notifyListeners();
    });
  }

  Future<void> addBooking(Booking booking) async {
    await _repository.addBooking(booking);

    try {
      await SmsService.sendSms(
        to: booking.phone,
        message:
          "Hello ${booking.customerName} your booking for ${booking.service} at ${booking.bookingDate.toLocal} has been confirmed. Thank you!",
      );
    } catch (e) {
      debugPrint("Error, sending SMS failed: $e");      
    }
  }
}
