import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoyaltyArt Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // sign out logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildTile(
              context,
              icon: Icons.calendar_today,
              label: "Bookings",
              onTap: () => Navigator.pushNamed(context, '/bookings'),
            ),
            _buildTile(
              context,
              icon: Icons.qr_code,
              label: "Loyalty",
              onTap: () => Navigator.pushNamed(context, '/loyalty'),
            ),
            _buildTile(
              context,
              icon: Icons.payments,
              label: "Payments",
              onTap: () => Navigator.pushNamed(context, '/payments'),
            ),
            _buildTile(
              context,
              icon: Icons.bar_chart,
              label: "Analytics",
              onTap: () => Navigator.pushNamed(context, '/admin'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.deepPurple),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../auth/auth_controller.dart';
// import '../../loyalty/loyalty_controller.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _loyaltyLoaded = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_loyaltyLoaded) {
//       final authController = Provider.of<AuthController>(context, listen: false);
//       final loyaltyController = Provider.of<LoyaltyController>(context, listen: false);
//       final userId = authController.currentUserId;
//       if (userId != null) {
//         loyaltyController.loadLoyalty(userId);
//         _loyaltyLoaded = true;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("LoyaltyArt Dashboard"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               // sign out logic here
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.count(
//           crossAxisCount: 2,
//           childAspectRatio: 1,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           children: [
//             _buildTile(
//               context,
//               icon: Icons.calendar_today,
//               label: "Bookings",
//               onTap: () => Navigator.pushNamed(context, '/bookings'),
//             ),
//             _buildTile(
//               context,
//               icon: Icons.qr_code,
//               label: "Loyalty",
//               onTap: () => Navigator.pushNamed(context, '/loyalty'),
//             ),
//             _buildTile(
//               context,
//               icon: Icons.payments,
//               label: "Payments",
//               onTap: () => Navigator.pushNamed(context, '/payments'),
//             ),
//             _buildTile(
//               context,
//               icon: Icons.bar_chart,
//               label: "Analytics",
//               onTap: () => Navigator.pushNamed(context, '/admin'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTile(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 48, color: Colors.deepPurple),
//             const SizedBox(height: 8),
//             Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }