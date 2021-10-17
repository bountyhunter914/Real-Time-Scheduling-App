import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:real_time_scheduling/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:real_time_scheduling/pages/settings_builder.dart';

/// Paul's Page
class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage>{

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeModel, child){
        return MaterialApp(
          title:"Settings",
          theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
          home: SettingsBuilder(),
        );
      })
    );
  }
}
