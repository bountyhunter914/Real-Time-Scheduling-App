import 'package:flutter/cupertino.dart';
import 'package:real_time_scheduling/theme_shared_preferences.dart';
import 'databaseV2.dart';

class ThemeModel extends ChangeNotifier{
  //bool _isDark = false;
  bool _isDark;
  String theme;
  ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModel(){
    //calls getThemedb, will add theme if not set
    getThemedb();
    if(theme != null){
      if(theme == "false")  _isDark = false;
      else _isDark = true;
    }

    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value){

    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();

    if(theme == 'false'){
      if(_isDark != false){
        insertThemedb("true");
      }
    }
    if(theme == 'true'){
      if(_isDark != true){
        insertThemedb("false");
      }
    }
  }

  //inserts theme string to db if not initialized
  insertThemedb(theme_value) async{
    DatabaseHelper helper = DatabaseHelper.instance;
    SettingEntry setting = new SettingEntry();
    setting.theme = theme_value;
    helper.setting_insert(setting);

  }

  //checks db to see if theme string is initialized
  getThemedb() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>>data = await helper.querySettings();
    if (data != null){
      theme = data[0]['Theme'];
    }
  }

  getThemePreferences() async{
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }
}