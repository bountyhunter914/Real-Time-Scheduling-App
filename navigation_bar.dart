import 'package:flutter/material.dart';
import 'package:real_time_scheduling/pages/calendar_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/main_page.dart';
import 'package:real_time_scheduling/pages/settings_page.dart';

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  NavigationBar({@required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'My Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'My Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.green,
      onTap: (int index) {
        print(index.toString());
        if (index == 0) {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => EventsPage(),
                transitionDuration: const Duration(seconds: 0),
              ));
        } else if (index == 1) {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => CalendarPage(),
                transitionDuration: const Duration(seconds: 0),
              ));
        } else if (index == 3) {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => SettingsPage(),
                transitionDuration: const Duration(seconds: 0),
              ));
        } else {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => MainPage(),
                transitionDuration: const Duration(seconds: 0),
              ));
        }
      },
    );
  }
}
