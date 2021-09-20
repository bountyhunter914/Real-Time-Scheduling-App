import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';

/// Preston's Page
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: const Align(
          alignment: Alignment.bottomCenter,
          child: NavigationBar()),
    );
  }
}
