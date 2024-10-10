import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({required bool isDarkMode})
      : _themeData = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme(bool isDarkMode) {
    _themeData = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
