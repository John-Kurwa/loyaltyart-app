import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loyaltyart/features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'firebase_options.dart';
import 'features/admin/admin_controller.dart';
import 'features/bookings/bookings_controller.dart';
import 'features/loyalty/loyalty_controller.dart';
import 'features/payments/payments_controller.dart';
import 'package:loyaltyart/features/auth/auth_controller.dart';
import 'package:loyaltyart/app/routes.dart';
import 'package:loyaltyart/app/notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => BookingsController()..loadBookings()),
        ChangeNotifierProvider(create: (_) => LoyaltyController()),
        ChangeNotifierProvider(create: (_) => PaymentsController()..loadPayments()),
        ChangeNotifierProvider(create: (_) => AdminController()..loadAnalytics()),
      ],
      child: const LoyaltyArtApp(),
    ),
  );
}

// Root widget for the app.
class LoyaltyArtApp extends StatelessWidget {
  const LoyaltyArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'loyaltyArt',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: isDarkMode? Brightness.light : Brightness.dark,
            )
          ),
          initialRoute: '/auth',
          onGenerateRoute: AppRoutes.generateRoute,
          routes: {
            '/': (context) => const HomePage(),
            '/auth': (context) =>  LoginPage(),
          },
        );
      },
    );
  }
}