import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:real_time_scheduling/databaseV2.dart';
/// Swati's Page
///
///
class MainPageStateful extends StatefulWidget {
  @override
  State<MainPageStateful> createState() => _MainPageStatefulWidget();
}
class _MainPageStatefulWidget extends State<MainPageStateful> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController eventController;
  List<dynamic> _selectedEvents;

  bool _isOn = false;
  void toggle() {
    setState(() => _isOn = !_isOn);
  }
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    eventController = TextEditingController();
    _selectedEvents = [];
  }
  // void getEventsForTheDay(date) async {
  //   DatabaseHelper helper = DatabaseHelper.instance;
  //   List<Map<String, dynamic>> data = await helper.queryEvents();
  //   for (var i in data) {
  //     if (i['Day'].toString() == date.day.toString()) {
  //       _selectedEvents.add(i['Title']);
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.error),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: const Text('Welcome!'),
        actions: [
          Switch(
              value: _isOn,
              onChanged: (value) {
                toggle();
              })
        ],
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text('Missed Events'),
                ),
              ),
              ListTile(
                  title: Text("STA 301 Recitation"),
                  // textColor: Colors.red,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("CSE 442 Tuesday Meeting"),
                  // textColor: Colors.red,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("X's Birthday Party"),
                  // textColor: Colors.red,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("CSE 250 lecture"),
                  // textColor: Colors.red,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                title: Text("Dinner at Y's"),
                // textColor: Colors.red,
                focusColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.twoWeeks,
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
                child: Text("Enter Event"),
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