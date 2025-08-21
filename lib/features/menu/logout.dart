import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loyaltyart/features/auth/auth_controller.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Logout'),
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ).then((shouldLogout) {
          if (shouldLogout == true) {
            if (!context.mounted) return;
            final authController =
                Provider.of<AuthController>(context, listen: false);

            authController.signOut().then((_) {
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            });
          }
        });
      },
    );
  }
}
