import 'package:flutter/material.dart';
import 'package:real_time_scheduling/pages/main_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/settings_page.dart';
import 'package:real_time_'
    'scheduling/pages/calendar_page.dart';
import 'ThemeModel.dart';
import 'package:real_time_scheduling/pages/test_events_page.dart';

void main() => runApp(const MyApp());

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key key,
    @required this.errorDetails,
  })  : assert(errorDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        child: Text(
          "Something is not right here...",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
      ),
      color: Colors.grey[700],
      margin: EdgeInsets.zero,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    ThemeModel().getThemedb();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      //theme: boo ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/main',
      routes:
      {
        '/main' : (context) => MainPageStateful(),
        '/events' : (context) =>  EventsPage(),
        '/settings' : (context) => SettingsPage(),
        '/calendar' : (context) => CalendarPage(),
      },
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };

        return widget;
      },
    );
  }
}
