import 'package:flutter/material.dart';
import 'package:real_time_scheduling/pages/main_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/settings_page.dart';
import 'package:real_time_scheduling/pages/calendar_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
      ),
      initialRoute: '/main',
      routes:
      {
        '/main' : (context) => const MainPage(),
        '/events' : (context) => const EventsPage(),
        '/settings' : (context) => const SettingsPage(),
        '/calendar' : (context) => const CalendarPage(),
      },
    );
  }
}