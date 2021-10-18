import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';

/// Max's Page
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key key}) : super(key: key);

  static CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
        appBar: AppBar(
          title: const Text('My Calendar'),
        ),
        /** Implement your page in body. Just make sure you leave the NavigationBar**/
        body: TableCalendar(
          startDay: DateTime.utc(2010, 10, 16),
          endDay: DateTime.utc(2030, 3, 14),
          calendarController: _controller,
        ),
        bottomNavigationBar: NavigationBar(selectedIndex: 1)
    );
  }
}
