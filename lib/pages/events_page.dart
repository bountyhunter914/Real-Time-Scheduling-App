import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:real_time_scheduling/event.dart';
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
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                        'Next Upcoming Event shown in dropdown',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Press Dropdown to View Events Today',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    EventAdder(),
                  ],
                ),
              ),
            ),
          ),
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
  DateTime selectedDate = DateTime.now();

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  List<Event> retEventList(){
    return this.eventsList;
  }

  void addEvent(text) {
    Event e = Event(text, this.selectedDate);
    eventsList.add(e);
  }

  @override
  Widget build(BuildContext context){
    return Column(
        children: <Widget>[
          DropDownState(this.eventsList),
          ElevatedButton(
              onPressed: (){
                _selectDate(context);
              },
              child: Text('Choose Date')
          ),
          Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
          TextField(
            controller: this.controller,
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
}

//sets up Stateful Widget for Dropdown bar on Events Page
class DropDownState extends StatefulWidget{
  final List<Event> events;
  DropDownState(this.events);
  @override
  State<DropDownState> createState() => DropDown(events);
}

//implementation of Dropdown Button from Flutter API
class DropDown extends State<DropDownState>{
  List<Event> events;
  List<String> eventNames = [];

  String mainEvent = '';

  DropDown(this.events);
  @override
  Widget build(BuildContext context){
    if(widget.events.isEmpty){
      mainEvent = 'Add Event';
      eventNames = [mainEvent];
    }
    else{
      eventNames = [];
      for (Event e in widget.events){
        eventNames.add(e.name);
      }
      mainEvent = eventNames[0];
    }
    //checks length of eventsList
    print(events.length);
    return DropdownButton<String>(
      value: mainEvent,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
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
          child: Text(value),
        );
      }).toList(),
    );
  }
}

