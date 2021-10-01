import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:real_time_scheduling/database.dart';

/// Preston's Page
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      //backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('My Events'),
        ),
        /** Implement your page in body. Just make sure you leave the NavigationBar**/
        body: EventsMain(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Create Event',style: TextStyle(color: Colors.white),),
          icon: const Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.white10,
        ),
        bottomNavigationBar: const NavigationBar(selectedIndex: 0,)
    );
  }
}

class EventsMain extends StatelessWidget{
  EventsMain({Key? key}) : super(key: key);
  final controllerTitle = TextEditingController();
  final controllerDate = TextEditingController();
  late String title;
  late String date;
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: controllerTitle,
                          decoration: InputDecoration(
                            labelText: 'Title'
                          ),
                          onChanged: (text){title = text;},
                        ),
                        TextField(
                          controller: controllerDate,
                          decoration: InputDecoration(
                              labelText: 'Date'
                          ),
                          onChanged: (text){date = text;},
                        ),
                        ElevatedButton(
                            onPressed: () async{
                              if(title != null && date != null){
                                Entry x = Entry();
                                x.event = "Event";
                                x.title = title;
                                x.date = date;
                                DatabaseHelper helper = DatabaseHelper.instance;
                                await helper.insert(x);
                              }
                            },
                            child: Text('Submit'))
                      ],
                    ),
                    const Text(
                        'Next Upcoming Event: ',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Placeholder Event 1',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.green,
                          )
                      ),
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
                  children: const [
                    Text(
                      'Press Dropdown to View Events Today',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    DropDownState()
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
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.green,
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

