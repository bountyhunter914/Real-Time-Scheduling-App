import 'package:flutter/material.dart';
import 'package:real_time_scheduling/database.dart';


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
          if(title != null && date != null){
            Entry event = Entry();
            event.date = date;
            event.title = title;
            event.event = "Events";
            DatabaseHelper helper = DatabaseHelper.instance;
            await helper.insert(event);
            print('inserted row');
          }
          data = await DatabaseHelper.instance.queryAll();
          for(var i in data){
            print(i);
          }
          setState(() {
            ready = true;
          });
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