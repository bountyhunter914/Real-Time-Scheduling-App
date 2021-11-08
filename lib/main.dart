import 'package:flutter/material.dart';
import 'package:real_time_scheduling/pages/main_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/settings_page.dart';
import 'package:real_time_'
    'scheduling/pages/calendar_page.dart';
import 'ThemeModel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    ThemeModel().getThemedb();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      initialRoute: '/main',
      routes:
      {
        '/main' : (context) => MainPageStateful(),
        '/events' : (context) =>  EventsPage(),
        '/settings' : (context) => SettingsPage(),
        '/calendar' : (context) => CalendarPage(),
      },
    );
  }
}
