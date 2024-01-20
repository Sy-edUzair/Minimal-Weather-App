import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  var isDarkModeEnabled = false;
  //getter
  bool get isDark => isDarkModeEnabled;

  //setter
  set isDark(bool isDark) {
    isDarkModeEnabled = isDark;
    notifyListeners();
  }

  void toggleTheme() async {
    isDarkModeEnabled = !isDark;
    final SharedPreferences storeTheme = await SharedPreferences.getInstance();
    await storeTheme.setBool('isDarkorNot', isDarkModeEnabled);
    notifyListeners();
  }

  initializeTheme() async {
    final SharedPreferences storeTheme = await SharedPreferences.getInstance();
    isDarkModeEnabled =
        storeTheme.getBool('isDarkorNot') ?? false; //default value is false
    notifyListeners();
  }
}
