import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';

/// Preston's Page
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: const EventsMain(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Create Event'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      bottomNavigationBar: const NavigationBar(selectedIndex: 0,)
    );
  }
}

class EventsMain extends StatelessWidget{
  const EventsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text(
              'Next Upcoming Event: Placeholder Event 1',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  backgroundColor: Colors.white)
          ),
          Text(
            'Press Dropdown to View Events Today',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          DropDownState()
        ],
      ),
    );
  }
}

//sets up Stateful Widget for Dropdown bar on Events Page
class DropDownState extends StatefulWidget{
  const DropDownState({Key? key}) : super(key: key);

  @override
  State<DropDownState> createState() => DropDown();
}

//implementation of Dropdown Button from Flutter API
class DropDown extends State<DropDownState>{
  String mainEvent = 'Placeholder Event 1';

  @override
  Widget build(BuildContext context){
    return DropdownButton<String>(
      value: mainEvent,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String? newValue){
        setState((){
          mainEvent = newValue!;
        });
      },
      //add implementation from '+' button
      items: <String>['Placeholder Event 1',
        'Placeholder Event 2',
        'Placeholder Event3',
        'Placeholder Event 4'].map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

