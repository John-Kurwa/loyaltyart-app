import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static const EdgeInsets pagePadding = EdgeInsets.all(16);

  static RoundedRectangleBorder roundedCard = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  static  const double buttonRadius = 16.0;
}
