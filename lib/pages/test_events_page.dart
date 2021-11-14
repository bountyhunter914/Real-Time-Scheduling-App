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
          if(ready) showEvents(),
        ],
      ),
    );
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
    print("ShowEvents Called");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       if(this.events != null) for(var i in this.events) Text(i[0] + " Year: " +i[1] + " Month: " + i[2] + " Day: " + i[3] + " Time: " + i[4] + ":" + i[5])
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