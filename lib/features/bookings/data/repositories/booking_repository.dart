import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyaltyart/features/bookings/bookings_model.dart';
// import '../bookings_model.dart';

class BookingRepository {
  final _bookingCollection = FirebaseFirestore.instance.collection('bookings');

  Future<void> addBooking(Booking booking) async {
    await _bookingCollection.doc(booking.id).set(booking.toMap());
  }

  Stream<List<Booking>> getBookings() {
    return _bookingCollection
        .orderBy('bookingDate')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList());
  }
}
