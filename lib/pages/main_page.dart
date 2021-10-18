import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:real_time_scheduling/pages/events_page.dart';
import 'package:real_time_scheduling/event.dart';

/// Swati's Page
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPageStateful(),
    );
  }
}

class MainPageStateful extends StatefulWidget {
  @override
  State<MainPageStateful> createState() => _MainPageStatefulWidget();
}

class _MainPageStatefulWidget extends State<MainPageStateful> {
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController eventController;
  List<dynamic> _selectedEvents;
  DateTime _focus = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    eventController = TextEditingController();
    _selectedEvents = [];
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
  //
  // @override
  // void dispose() {
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                highlightToday: true,
                todayColor: Colors.grey,
              ),
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events, _) {
                setState(() {
                  _selectedEvents = events;
                });
              },
            ),
            Divider(
              height: 20,
              thickness: 5,
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showAddDialog,
      ),

      //   // firstDay: DateTime.utc(1910, 09, 2 4),
      //   // lastDay: DateTime.utc(2100,09,24),

      //   // calendarFormat: CalendarFormat.twoWeeks,

      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Expanded(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: Colors.white10,
      //                 borderRadius: BorderRadius.circular(16)),
      //             child: Padding(
      //               padding: const EdgeInsets.all(16.0),
      //               child: Column(
      //                 children: const [
      //                   Padding(
      //                     padding: EdgeInsets.all(8.0),
      //                     child: Text(
      //                       "Today's Events",
      //                       style: TextStyle(
      //                           fontWeight: FontWeight.bold, fontSize: 17),
      //                     ),
      //                   ),
      //                   Text("CSE 442 Demo"),
      //                   Text("Anime Monday"),
      //                   Text("Gym"),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: Colors.white10,
      //                 borderRadius: BorderRadius.circular(16)),
      //             child: Padding(
      //               padding: const EdgeInsets.all(16.0),
      //               child: Column(
      //                 children: const [
      //                   Padding(
      //                     padding: EdgeInsets.all(8.0),
      //                     child: Text(
      //                       "Event Invites",
      //                       style: TextStyle(
      //                           fontWeight: FontWeight.bold, fontSize: 17),
      //                     ),
      //                   ),
      //                   Text("Max's Birthday Party"),
      //                   Text("Checkup: Dr. Wildon"),
      //                   Text("Family Vacation"),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   )
      // ],

      bottomNavigationBar: NavigationBar(selectedIndex: 2),
    );
  }

  showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(
                  controller: eventController,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Enter"),
                    onPressed: () {
                      if (eventController.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        if (_events[_calendarController.selectedDay] != null) {
                          _events[_calendarController.selectedDay]
                              .add(eventController.text);
                        } else {
                          _events[_calendarController.selectedDay] = [
                            eventController.text
                          ];
                        }
                        eventController.clear();
                        Navigator.pop(context);
                      });
                    },
                  )
                ]));
  }
}
