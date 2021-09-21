import 'package:flutter/material.dart';
import 'package:real_time_scheduling/pages/calendar_page.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/pages/main_page.dart';
import 'package:real_time_scheduling/pages/settings_page.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
        Expanded(
          child: ElevatedButton(
            child: const Text('My Events',
            textAlign: TextAlign.center,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const EventsPage()));
            },
          ),
        ),
        Expanded(
          child: ElevatedButton(
            child: const Text('My Calendar',
            textAlign: TextAlign.center,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CalendarPage()));
            },
          ),
        ),
        Expanded(
          child: ElevatedButton(
            child: const Text('Home',
            textAlign: TextAlign.center,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MainPage()));
            },
          ),
        ),
        Expanded(
          child: ElevatedButton(
            child: const Text('Settings',
            textAlign: TextAlign.center,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const SettingsPage()));
            },
          ),
        ),
      ],
    );
  }
}