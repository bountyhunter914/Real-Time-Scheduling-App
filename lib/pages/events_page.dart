//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:real_time_scheduling/event.dart';
import 'package:real_time_scheduling/databaseV2.dart';
/// Preston's Page
///
///
class EventsPage extends StatelessWidget {
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
        body: EventsMain(),
        bottomNavigationBar: NavigationBar(selectedIndex: 0,)
    );
  }
}

class EventsMain extends StatelessWidget{
  EventsMain();
  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  //color: Colors.white10,
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:120, bottom: 120),
                child: Column(
                  children: [
                    EventAdder(),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: DropDownState()
          )
          // const Text(
          //   'Press Dropdown to View Events Today',
          //   textAlign: TextAlign.center,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          // ),
          // const DropDownState()
        ],
      ),
    );
  }
}

class EventAdder extends StatefulWidget{

  @override
  _EventAdderState createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder>{
  final controller = TextEditingController();
  List<Event> eventsList = [];
  List<Map<String,dynamic>> events;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<EventEntry> eventInstances = [];


  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  //adds events w database
  void addEvent(entry) async{//addEvent(text) {
    //Event e = Event(text, this.selectedDate);
    //eventsList.add(e);
    DatabaseHelper helper = DatabaseHelper.instance;
    EventEntry inserted = new EventEntry();
    inserted.day = this.selectedDate.day;
    inserted.month = this.selectedDate.month;
    inserted.year = this.selectedDate.year;
    inserted.hour = this.selectedTime.hour;
    inserted.minute = this.selectedTime.minute;
    inserted.title = entry;
    await helper.event_insert(inserted);
    print(inserted.title);
    controller.clear();
  }

  // void getEvents () async{
  //     DatabaseHelper helper = DatabaseHelper.instance;
  //     events = await helper.queryEvents();
  //     for(var i in events){
  //       EventEntry event = new EventEntry.fromMap(i);
  //       eventInstances.add(event);
  //     }
  //     print("Got Events maybe???");
  // }
  @override
  Widget build(BuildContext context){
    return Column(
        children: <Widget>[
          //DatePicker code found in https://codesinsider.com/flutter-
          // datepicker-widget-example-tutorial/
          ElevatedButton(
              onPressed: (){
                _selectDate(context);
              },
              child: Text('Choose Date')
            ),
          Text("${selectedDate.month}/${selectedDate.day}/${selectedDate.year}"),
          ElevatedButton(onPressed: (){
            _selectTime(context);
            },
              child: Text('Choose Time')
          ),
          TextField(
            controller: this.controller,
            maxLength: 15,
            decoration: InputDecoration(labelText: "Add Event Name:"),
            onSubmitted: (text) => this.addEvent(text),
          ),
        ]
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  _selectTime(BuildContext context) async{
    final TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: selectedTime);
        if(time != null)
          setState(() {
            selectedTime = time;
          });
  }
}

//sets up Stateful Widget for Dropdown bar on Events Page
class DropDownState extends StatefulWidget{
  @override
  State<DropDownState> createState() => DropDown();
}

//implementation of Dropdown Button from Flutter API
class DropDown extends State<DropDownState>{
  List<String> eventNames = [];
  String mainEvent = '';

  void getEvents() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>>data = await helper.queryEvents();
    for(var i in data){
      if(i['Day'].toString() == DateTime.now().day.toString() &&
          i['Month'].toString() == DateTime.now().month.toString()){
        if(!eventNames.contains(i['Title'])) {
          eventNames.add(i['Title']);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context){
    getEvents();
    if(eventNames.length == 0){
      mainEvent = 'View Event(s)';
      eventNames = [mainEvent];
    }
    else{
      mainEvent = eventNames[0];
    }
    //checks length of eventsList
    return DropdownButton<String>(

      value: mainEvent,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      //style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String newValue){
        setState((){
          mainEvent = newValue;
        });
      },
      //add implementation from '+' button
      items: eventNames.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,

          child: Text(value)
        );
      }).toList(),
    );
  }
}



