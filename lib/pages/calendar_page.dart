import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:real_time_scheduling/databaseV2.dart';

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
  List<List<String>> events;

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
    start();
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
  List<List<String>> sortData(List<Map<String,dynamic>> data){
    List<List<String>> sortedData = [];
    // print("\n");
    // print(data);
    // print("\n");
    for(var i in data){
      sortedData.add([i['Title'],i['Year'].toString(), i['Month'].toString(),i['Day'].toString(), i['Hour'].toString(),i['Minute'].toString()]);
    }
    // print(sortedData);
    return sortedData;
  }

  start() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String,dynamic>> data = await helper.queryEvents();
    this.events = sortData(data);
      for(var i in this.events){
          int month = int.parse("3");
          List<int> info = [int.parse(i[2]),int.parse(i[3]),int.parse(i[4]),int.parse(i[5]),0,0,0];
          // DateTime event = new DateTime(int.parse(i[1]),int.parse(i[2]),int.parse(i[3]),int.parse(i[4]),int.parse(i[5]),0,0,0);
          // _events[DateTime.utc(int.parse(i[1]),int.parse(i[2]),int.parse(i[3]),int.parse(i[4]),int.parse(i[5]),0,0,0)] = [i[0]];
          DateTime date = DateTime.utc(int.parse(i[1]),int.parse(i[2]),int.parse(i[3]),int.parse(i[4]),int.parse(i[5]),0,0,0);
          setState(() {
            if(_events[date] != null && !check(_events[date], i[0])){
              _events[date].insert(0,i[0]);
            }
            else if(_events[date] == null) {
              _events[date] = [i[0]];
            }
          });
      }
    // print(events);
  }

  bool check(List<dynamic> x, y){
    for(var i in x){
      if(i == y){
        return true;
      }
    }
    return false;
  }
}
