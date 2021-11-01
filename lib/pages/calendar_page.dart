import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event_adder.dart';

/// Max's Page
class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageStatefulWidget();
}



class _CalendarPageStatefulWidget extends State<CalendarPage> {

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      appBar: AppBar(
        title: const Text('My Calendar'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
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
      bottomNavigationBar: NavigationBar(selectedIndex: 1)
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
