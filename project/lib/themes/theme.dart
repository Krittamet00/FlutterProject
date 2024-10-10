import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),
    cardColor: Colors.grey[800], // Ensures card contrast in dark mode
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
