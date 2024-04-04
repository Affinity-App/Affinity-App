import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Set to light mode by default

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    // Removed the bool isOn parameter
    // Toggle the theme based on the current mode
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}
