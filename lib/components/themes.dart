import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  final String key = "theme";
  SharedPreferences? _prefs;

  ThemeNotifier() : _currentTheme = whiteTheme {
    _loadFromPrefs();
  }

  ThemeData get currentTheme => _currentTheme;

  Future<void> toggleTheme() async {
    _currentTheme = (_currentTheme == whiteTheme) ? blueTheme : whiteTheme;
    await _saveToPrefs(_currentTheme == whiteTheme ? 'white' : 'blue');
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    final themeStr = _prefs!.getString(key) ?? 'white';
    _currentTheme = (themeStr == 'blue') ? blueTheme : whiteTheme;
    notifyListeners();
  }

  Future<void> _saveToPrefs(String themeStr) async {
    await _initPrefs();
    await _prefs!.setString(key, themeStr);
  }
}

ThemeData whiteTheme = ThemeData(
  primaryColor: Colors.white,
  hintColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  // Define other text styles as needed
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.black, // Or any other color
  ),
  // Add other customizations as needed
);

ThemeData blueTheme = ThemeData(
  primaryColor: Colors.blue,
  hintColor: Colors.white,
  scaffoldBackgroundColor: Colors.blue,
  // Define other text styles as needed
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.blue,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black, // Or any other color
  ),
  // Add other customizations as needed
);

