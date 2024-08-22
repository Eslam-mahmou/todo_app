import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigAppProvider extends ChangeNotifier{
  String currentLanguage="en";
  ThemeMode currentThemeMode = ThemeMode.light;
  void changeLanguage(String language){
    if(language==currentLanguage){
      return;
    }
    currentLanguage = language;
    notifyListeners();
  }
  void changeThemeMode(ThemeMode themeMode){
    if(themeMode==currentThemeMode){
      return;
    }
    currentThemeMode = themeMode;
    notifyListeners();
  }
 bool isDarkMode(){
    return currentThemeMode == ThemeMode.dark;
  }
  getBackgroundColor(){
    return isDarkMode()? Colors.black : Colors.white;
  }
}