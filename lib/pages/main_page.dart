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
  List<List<String>> events;
  bool ready = false;
  bool _isOn = false;
  void toggle() {
    setState(() => _isOn = !_isOn);
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _calendarController = CalendarController();
  //   _events = {};
  //   eventController = TextEditingController();
  //   _selectedEvents = [];
  // }
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
    start();
    start();
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Today's Events
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('  Today\'s Events  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      if(ready) showEvents(),
                    ],
                  ),
                ),
              ),
            ),
            //Upcoming This week
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.lightBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Upcoming Events',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      if(ready) showUpcomingEvents(),
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
      bottomNavigationBar: NavigationBar(selectedIndex: 2),
    );
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
    setState(() {
      ready = true;
    });
    // print(events);
  }


  SingleChildScrollView showEvents(){
    // print("ShowEvents Called");
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(this.events != null) for(var i in this.events) if(DateTime.now().day.toString() == i[3] && DateTime.now().month.toString() == i[2] && DateTime.now().year.toString() == i[1])
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(child: Text(textDisplay(i),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),)),
          )
        ],
      ),
    );

  }

  SingleChildScrollView showUpcomingEvents(){
    // print("ShowEvents Called");
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(this.events != null)
            for(var i in this.events)
              if(DateTime.now().day.toString() != i[3])
              // if(DateTime.now().day.toString() != i[3] && DateTime.now().month.toString() != i[2] && DateTime.now().year.toString() != i[1])
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(child: Text(textDisplay(i),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                ),)),
            )
        ],
      ),
    );

  }




  String textDisplay(List<String> i){
    var x = i[0] + "\n"+" Date: " + i[2] + "/" + i[3]+ "/" +i[1]  + " Time: " + i[4] + ":";
    if(i[5]== "0"){
      x += "00";
    }
    else if(i[5].length == 1){
      x += "0" + i[5];
    }
    else {
      x += i[5];
    }
    return x;
  }

}