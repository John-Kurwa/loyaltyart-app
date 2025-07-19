import 'package:flutter/material.dart';
import 'package:loyaltyart/core/services/sms_service.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyaltyart/features/admin/admin_controller.dart';
import '../../../auth/auth_controller.dart';


// class AdminDashboard extends StatelessWidget {
//   const AdminDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<AdminController>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Analytics')),
//       body: RefreshIndicator(
//         onRefresh: () => controller.loadAnalytics(),
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             Card(
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Total Revenue'),
//                 subtitle: Text('KES ${controller.totalRevenue.toStringAsFixed(2)}'),
//               ),
//             ),
//             Card(
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Total Bookings'),
//                 subtitle: Text('${controller.totalBookings}'),
//               ),
//             ),
//             Card(
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Total Loyalty Scans'),
//                 subtitle: Text('${controller.totalLoyaltyScans}'),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Top Customers (by points)',              
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             ...controller.topCustomers.entries.map((entry) => ListTile(
//                   leading: const Icon(Icons.person),
//                   title: Text(entry.key),
//                   trailing: Text('${entry.value} points'),
//                 )),
//                 const SizedBox(height: 16),
//             const Text(
//               'Revenue by Month',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(
//               height: 200,
//               child: controller.revenueChart.isEmpty
//                   ? const Center(child: CircularProgressIndicator())
//                   : charts.BarChart(
//                       controller.revenueChart,
//                       animate: true,
//                   ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Bookings by Month',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(
//               height: 200,
//               child: controller.bookingsChart.isEmpty
//                   ? const Center(child: CircularProgressIndicator())
//                   : charts.TimeSeriesChart(
//                       controller.bookingsChart,
//                       animate: true,
//                   ),
//             ), 
//              ElevatedButton.icon(
//               icon: const Icon(Icons.sms),
//               label: const Text('Send Tomorrow’s Reminders'),
//               onPressed: () async {
//                 final tomorrow = DateTime.now().add(const Duration(days: 1));
//                 final bookings = await FirebaseFirestore.instance
//                     .collection('bookings')
//                     .where('bookingDate',
//                       isGreaterThanOrEqualTo: DateTime(
//                           tomorrow.year, tomorrow.month, tomorrow.day))
//                     .where('bookingDate',
//                       isLessThan: DateTime(
//                           tomorrow.year, tomorrow.month, tomorrow.day + 1))
//                     .get();

//                 for (var doc in bookings.docs) {
//                   final data = doc.data();
//                   try {
//                     await SmsService.sendSms(
//                       to: data['phone'],
//                       message:
//                           'Reminder: Your booking for ${data['service']} is tomorrow at ${data['bookingDate']}. See you then!',
//                   );
//                   } catch (e) {
//                     debugPrint('SMS reminder failed: $e');
//                   }
//                 }
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Reminders sent!')),
//               );
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.logout),
//                   label: const Text('Logout'),
//                   onPressed: () async {
//                     await Provider.of<AuthController>(context, listen: false).signOut();                        
//                     Navigator.pushReplacementNamed(context, '/login');
//                   },
//                 );
//               },
//             ),          
//           ],
//         ),
//       ),
//     );
//   }
// }


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Analytics')),
      body: RefreshIndicator(
        onRefresh: () => controller.loadAnalytics(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ...existing cards and charts...
            ElevatedButton.icon(
              icon: const Icon(Icons.sms),
              label: const Text('Send Tomorrow’s Reminders'),
              onPressed: () async {
                final tomorrow = DateTime.now().add(const Duration(days: 1));
                final bookings = await FirebaseFirestore.instance
                    .collection('bookings')
                    .where('bookingDate',
                      isGreaterThanOrEqualTo: DateTime(
                          tomorrow.year, tomorrow.month, tomorrow.day))
                    .where('bookingDate',
                      isLessThan: DateTime(
                          tomorrow.year, tomorrow.month, tomorrow.day + 1))
                    .get();

                for (var doc in bookings.docs) {
                  final data = doc.data();
                  try {
                    await SmsService.sendSms(
                      to: data['phone'],
                      message:
                          'Reminder: Your booking for ${data['service']} is tomorrow at ${data['bookingDate']}. See you then!',
                    );
                  } catch (e) {
                    debugPrint('SMS reminder failed: $e');
                  }
                }
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reminders sent!')),
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () async {
                await Provider.of<AuthController>(context, listen: false).signOut();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}