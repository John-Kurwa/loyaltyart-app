import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loyaltyart/features/admin/admin_controller.dart';
import 'package:loyaltyart/features/auth/presentation/pages/login_page.dart';
// import 'package:loyaltyart/features/home/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'app/routes.dart';
import 'app/theme.dart';
// import 'core/services/notification_service.dart';
import 'features/auth/auth_controller.dart';
import 'features/bookings/bookings_controller.dart';
import 'features/loyalty/loyalty_controller.dart';
import 'features/payments/payments_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(
          create: (_) => BookingsController()..loadBookings(),
        ),
        ChangeNotifierProvider(create: (_) => LoyaltyController()),
        ChangeNotifierProvider(
          create: (_) => PaymentsController()..loadPayments(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminController()..loadAnalytics(),
        ),
      ],
      child: const LoyaltyArtApp(),
    ),
  );
}

class LoyaltyArtApp extends StatelessWidget {
  const LoyaltyArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return StreamBuilder(
      stream: authController.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: loyaltyTheme,
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: '/home',
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: loyaltyTheme,
            home: LoginPage(),
          );
        }
      },
    );
  }
}
