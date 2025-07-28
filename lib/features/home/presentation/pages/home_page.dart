import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loyaltyart/features/auth//auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
                await Provider.of<AuthController>(context, listen: false).signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },            
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  _buildTile(
                    context,
                    icon: Icons.calendar_today,
                    label: "Bookings",
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/bookings'),
                  ),
                  _buildTile(
                    context,
                    icon: Icons.qr_code,
                    label: "Loyalty",
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/loyalty'),
                  ),
                  _buildTile(
                    context,
                    icon: Icons.payments,
                    label: "Payments",
                    color: Colors.teal,
                    onTap: () => Navigator.pushNamed(context, '/payments'),
                  ),
                  _buildTile(
                    context,
                    icon: Icons.bar_chart,
                    label: "Analytics",
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/admin'),
                  ),
                ],
              ),
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
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}                  