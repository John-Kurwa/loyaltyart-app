import 'package:flutter/material.dart';
import 'package:loyaltyart/features/home/presentation/pages/home_page.dart';
import '../features/bookings/presentation/pages/bookings_page.dart';
import '../features/loyalty/presentation/pages/loyalty_page.dart';
import '../features/payments/presentation/pages/payments_page.dart';
import '../features/admin/presentation/pages/admin_dashboard.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/bookings':
        return MaterialPageRoute(builder: (_) => const BookingsPage());
      case '/loyalty':
        return MaterialPageRoute(builder: (_) => const LoyaltyPage());
      case '/payments':
        return MaterialPageRoute(builder: (_) => const PaymentsPage());
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case '/login':
        return MaterialPageRoute(builder: (_) =>  LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
