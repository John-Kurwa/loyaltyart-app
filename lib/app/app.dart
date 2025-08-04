import 'package:flutter/material.dart';
import 'package:loyaltyart/app/routes.dart';
// import 'theme.dart';

class LoyaltyArtApp extends StatelessWidget {
  const LoyaltyArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'loyaltyArt',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
