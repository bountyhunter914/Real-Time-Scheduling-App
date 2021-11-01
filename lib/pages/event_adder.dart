import 'package:flutter/material.dart';
import 'package:real_time_scheduling/databaseV2.dart';

//Used to test database
class EventAdder extends StatefulWidget {
  const EventAdder();
  @override
  _EventAdderState createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder> {
  final controller_title = TextEditingController();
  final controller_date = TextEditingController();
  String title;
  String date;
  List<String> Events;
  List<Map<String,dynamic>> data;
  bool ready = false;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            controller: controller_title,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Title"
            ),
            onChanged: (text){
              title = text;
            },
          ),
        ),
        Container(
          child: TextField(
            controller: controller_date,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "date"
            ),
            onChanged: (text){
              date = text;
            },
          ),
        ),
        RaisedButton(onPressed: ()async {
          EventEntry event = EventEntry();
          event.title = "Test";
          event.year = 2021;
          event.month = 10;
          event.day = 28;
          event.minute = 30;
          event.hour = 10;
          DatabaseHelper helper = DatabaseHelper.instance;
          await helper.event_insert(event);
          print('inserted row');
          data = await DatabaseHelper.instance.queryEvents();
          for(var i in data){
            print(i);
          }
          SettingEntry set = SettingEntry();
          set.username = 'bountyhunter914';
          set.offline = 'FALSE';
          set.theme = 'TRUE';
          set.name = 'Jean';
          await helper.setting_insert(set);
          data = await helper.querySettings();
          for(var i in data){
            print(i);
          }
        },
          child: Text('Submit'),
        ),
        if(ready) showEvents(sortData(data))
      ],
    );
  }
}

Column showEvents(List<List<String>> data){
  print("ShowEvents Called");
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      for(var i in data) Text(i[1] + " Date: " +i[0])
    ],
  );

}

List<List<String>> sortData(List<Map<String,dynamic>> data){
  List<List<String>> sortedData = [];
  for(var i in data){
      sortedData.add([i['Date'].toString(),i['Title']]);
  }
  return sortedData;
}