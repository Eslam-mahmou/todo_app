import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigAppProvider extends ChangeNotifier {
  Locale locale =const Locale("en");
  ThemeMode themeMode = ThemeMode.light;

  void changeLanguage(String language) {
  locale=Locale(language);
  saveLanguage(language);
    notifyListeners();
  }
 Future<void> saveLanguage(String language) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language_code", language);
  }
 Future<void> getLang()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString("language_code")??"en";

     locale=Locale(language);
     notifyListeners();

  }

  void changeThemeMode(ThemeMode theme) {
  themeMode=theme;
  saveTheme(theme);
  notifyListeners();
  }

  bool isDarkMode() {
    return themeMode == ThemeMode.dark;
  }

  getBackgroundColor() {
    return isDarkMode() ? Colors.black : Colors.white;
  }

  void saveTheme(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(themeMode==ThemeMode.light){
      prefs.setString("theme", "light");
    }
    else{
      prefs.setString("theme", "dark");
    }
  }

  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString("theme");
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
