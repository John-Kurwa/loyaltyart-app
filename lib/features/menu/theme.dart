import 'package:flutter/material.dart';

/// Global notifier to handle dark/light mode switching
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true);

/// Theme manager class
class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black54,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}

/// Widget to show a theme toggle menu (Light/Dark options)
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, _) {
        return PopupMenuButton<String>(
          icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          onSelected: (value) {
            if (value == "Light") {
              isDarkModeNotifier.value = true;
            } else if (value == "Dark") {
              isDarkModeNotifier.value = false;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "Light",
              child: Text("Light Mode"),
            ),
            const PopupMenuItem(
              value: "Dark",
              child: Text("Dark Mode"),
            ),
          ],
        );
      },
    );
  }
}
