import 'package:flutter/cupertino.dart';
import 'package:real_time_scheduling/theme_shared_preferences.dart';

class ThemeModel extends ChangeNotifier{
  bool _isDark;
  ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModel(){
    //calls getThemedb, will add theme if not set
    getThemedb();
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>>data = await helper.querySettings();
    for(var i in data){
      if(i["theme"].toString() == "false"){
        _isDark = false;
      }else if(i["theme"].toString() == "true"){
        _isDark = true;
      }
    }

    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value){
    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }

  //inserts theme string to db if not initialized
  insertThemedb() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    SettingEntry setting = new SettingEntry();
    setting.theme = "false";
    await helper.event_insert(setting);

  }

  //checks db to see if theme string is initialized
  getThemedb() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>>data = await helper.querySettings();
    for(var i in data){
      if(i["theme"].toString() == ""){
        insertThemedb();
      }
    }
  }

  getThemePreferences() async{
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }
}