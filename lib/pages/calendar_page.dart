import 'package:flutter/material.dart';
import 'package:real_time_scheduling/components/navigation_bar.dart';

/// Max's Page
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('My Calendar'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: const Align(
          alignment: Alignment.bottomCenter,
          child: NavigationBar(selectedIndex: 1)),
    );
  }
}
