import 'package:flutter/cupertino.dart';
import 'package:real_time_scheduling/theme_shared_preferences.dart';
import 'package:real_time_scheduling/databaseV2.dart';

class ThemeModel extends ChangeNotifier{
  bool _isDark;
  ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModel() {
    //Inserts database
    insert_data("false");
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

 insert_data(data) async{
   DatabaseHelper helper = DatabaseHelper.instance;
   SettingEntry setting = new SettingEntry();
   setting.theme = data;
   await helper.setting_insert(setting);
}