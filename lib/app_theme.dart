import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue, // Change this to your accent color
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue, // Change this to your app bar color
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
    // Define more theme attributes as needed
    // For example: textTheme, buttonTheme, etc.
  );

  static ThemeData darkTheme = ThemeData(
    // Define dark theme data if needed
    // You can specify different colors and styles for dark mode
    // For example:
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
    // Define more theme attributes as needed for dark mode
  );

  // Function to toggle between light and dark themes
  static ThemeData getThemeData(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
