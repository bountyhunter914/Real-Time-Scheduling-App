import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:real_time_scheduling/databaseV2.dart';
import 'event_adder.dart';


class EventsPageV2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      //backgroundColor: Colors.green,
        appBar: AppBar(
          title: Text('My Events'),
        ),
        /** Implement your page in body. Just make sure you leave the NavigationBar**/
        body: EventsMainV2(),
        bottomNavigationBar: NavigationBar(selectedIndex: 0,)
    );
  }
}



class EventsMainV2 extends StatefulWidget{
  EventsMainV2();
  @override
  _EventsMainV2State createState() => _EventsMainV2State();

}

class _EventsMainV2State extends State<EventsMainV2> {
  DateTime date;
  bool ready = false;
  final controller_title = TextEditingController();
  String title;
  List<List<String>> events;
  @override
  Widget build(BuildContext context) {
    start();
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: TextField(
                controller: controller_title,
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
            ),),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                //color: Colors.white10,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: DateTimePickerFormField(
                inputType: InputType.both,
                format: DateFormat("MMMM d, yyyy 'at' h:mma"),
                decoration: InputDecoration(
                    labelText: 'Event Entry'
                ),
                onChanged: (dt) {
                  setState(() => date = dt);
                  start();
                  print(date);
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                start();
                if (date != null) {
                  input_date_to_entry(date);
                  title = "";
                  date = null;
                }
              },
              child: Text("Submit")),
          if(ready) showEvents()
          ],
      )
    );
  }


   String createDate(String event, String monthNum, String day, String year, String hour, String minute){
     List<String> months = ['January', 'February', 'March', 'April',
       'May', 'June', 'July', 'August',
       'September', 'October', 'November', 'December'];
     String month = '';
     String am_pm = '';
     String fixHour = '';
     if(monthNum == '1') month = months[0];
     if(monthNum == '2') month = months[1];
     if(monthNum == '3') month = months[2];
     if(monthNum == '4') month = months[3];
     if(monthNum == '5') month = months[4];
     if(monthNum == '6') month = months[5];
     if(monthNum == '7') month = months[6];
     if(monthNum == '8') month = months[7];
     if(monthNum == '9') month = months[8];
     if(monthNum == '10') month = months[9];
     if(monthNum == '11') month = months[10];
     if(monthNum == '12') month = months[11];

     if(hour == '12' || hour == '13' || hour == '14' || hour == '15'
         || hour == '16' || hour == '17' || hour == '18' || hour == '19'
          || hour == '20' || hour == '21' || hour == '22' || hour == '23'){
       am_pm = 'pm';
     } else am_pm = 'am';

     if(hour == '13') fixHour = '1';
     if(hour == '14') fixHour = '2';
     if(hour == '15') fixHour = '3';
     if(hour == '16') fixHour = '4';
     if(hour == '17') fixHour = '5';
     if(hour == '18') fixHour = '6';
     if(hour == '19') fixHour = '7';
     if(hour == '20') fixHour = '8';
     if(hour == '21') fixHour = '9';
     if(hour == '22') fixHour = '10';
     if(hour == '23') fixHour = '11';
     if(hour == '0') fixHour = '12';


     return event + ' - ' + month + ' ' + day + ', ' + year + ' at ' + fixHour + ':' + minute + am_pm;
   }

   input_date_to_entry(DateTime date) async {
    EventEntry event = EventEntry();
    event.month = date.month;
    event.year = date.year;
    event.day = date.day;
    event.minute = date.minute;
    event.hour = date.hour;
    event.title = title;
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.event_insert(event);
  }

  Column showEvents(){
    int cond = 0;
    if (events.length < 15){
      cond = events.length;
    }
    else{
      cond = 15;
    }
    print("ShowEvents Called");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //listview.builder would go here ; https://api.flutter.dev/flutter/widgets/ListView-class.html
        //i[0] is event, 1 is year, 2 is month, 3 is day, 4 is hour, minute is 5
       if(this.events != null) for(var i = 0; i < cond; ++i) Text(createDate(this.events[i][0], this.events[i][2], this.events[i][3], this.events[i][1], this.events[i][4], this.events[i][5]),
                                                              style: TextStyle(color: Colors.white,
                                                                              backgroundColor: Colors.blueAccent),)
      ],
    );

  }

  List<List<String>> sortData(List<Map<String,dynamic>> data){
    List<List<String>> sortedData = [];
    print("\n");
    print(data);
    print("\n");
    for(var i in data){
      sortedData.add([i['Title'],i['Year'].toString(), i['Month'].toString(),i['Day'].toString(), i['Hour'].toString(),i['Minute'].toString()]);
    }
    print(sortedData);
    return sortedData;
  }

   start() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String,dynamic>> data = await helper.queryEvents();
    this.events = sortData(data);
    setState(() {
      ready = true;
    });
    print(events);
  }

  
}