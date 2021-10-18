import 'package:flutter/cupertino.dart';
import 'package:real_time_scheduling/theme_shared_preferences.dart';

class ThemeModel extends ChangeNotifier{
  bool _isDark;
  ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModel(){
    _isDark = false;
    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value){
    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }

  getThemePreferences() async{
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }
}