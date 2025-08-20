import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:loyaltyart/features/auth/auth_controller.dart';
import 'package:loyaltyart/app/notifiers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Color(0xFFF8F8F8),  
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Text('Menu')
              ),
              ListTile(
                title: Text ('Notifications'),
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },                
              ),
              ListTile(
                title: Text ('Messages'),
                onTap: () {
                  Navigator.pushNamed(context, '/messages');
                },                
              ),
              ListTile(
                title: Text ('Theme'),
                onTap: () {
                  Navigator.pushNamed(context, '/theme');
                },                
              ),
              ListTile(
                title: Text ('About'),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },                
              ),
              ListTile(
                title: Text ('Logout'),
                onTap: () {
                  Navigator.pushNamed(context, '/logout');
                },                
              ),
            ]      
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "LoyaltyArt",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.grey[500],        
        leading: isMobile(context) // show menu only on mobile
      ? Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        )
      : null, //nothing on larger screens
        actions: [
          IconButton(
            onPressed: () {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
          const SizedBox(width: 8),
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //     showDialog<bool>(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: const Text('Confirm Logout'),
          //         content: const Text('Are you sure you want to log out?'),
          //         actions: [
          //           TextButton(
          //             onPressed: () => Navigator.of(context).pop(false),
          //             child: const Text('No'),
          //           ),
          //           TextButton(
          //             onPressed: () => Navigator.of(context).pop(true),
          //             child: const Text('Yes'),
          //           ),
          //         ],
          //       ),
          //     ).then((shouldLogout) {
          //       if (shouldLogout == true) {
          //         if (!context.mounted) return;
          //         final authController = Provider.of<AuthController>(
          //           context,
          //           listen: false,
          //         );
          //         authController.signOut().then((_) {
          //           if (!context.mounted) return;
          //           Navigator.pushReplacementNamed(context, '/login');
          //         });
          //       }
          //     });
          //   },
          // ),
        ],
      ),
      //Bottom navigation bar
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: ''),
          NavigationDestination(icon: Icon(Icons.search), label: ''),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, BoxConstraints constarints) {
          final widthScreen = constarints.maxWidth;
          final isLargeScreen = widthScreen > 600;
          return Center(
            child: FractionallySizedBox(
              widthFactor: isLargeScreen ? 0.5 : 1.0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: isLargeScreen
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                        children: [
                          _buildTile(
                            context,
                            icon: Icons.calendar_today,
                            label: "Bookings",
                            color: Colors.purpleAccent,
                            onTap: () =>
                                Navigator.pushNamed(context, '/bookings'),
                          ),
                          _buildTile(
                            context,
                            icon: Icons.qr_code,
                            label: "Loyalty",
                            color: Colors.purpleAccent,
                            onTap: () =>
                                Navigator.pushNamed(context, '/loyalty'),
                          ),
                          _buildTile(
                            context,
                            icon: Icons.payments,
                            label: "Payments",
                            color: Colors.purpleAccent,
                            onTap: () =>
                                Navigator.pushNamed(context, '/payments'),
                          ),
                          _buildTile(
                            context,
                            icon: Icons.bar_chart,
                            label: "Analytics",
                            color: Colors.purpleAccent,
                            onTap: () => Navigator.pushNamed(context, '/admin'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // color: Colors.black.withOpacity(0.1),
              color: color.withAlpha((0.1 * 255).toInt()),
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
              backgroundColor: color.withAlpha((0.1 * 255).toInt()),
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
