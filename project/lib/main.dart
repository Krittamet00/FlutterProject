import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isDarkMode: false), // Set initial theme
      child: SavingsApp(),
    ),
  );
}

class SavingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Savings Management',
          theme: themeProvider.themeData,
          home: LoginScreen(),
        );
      },
    );
  }
}
