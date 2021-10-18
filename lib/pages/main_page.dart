import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';


/// Swati's Page
class MainPage extends StatelessWidget {

  const MainPage();
  @override
  Widget build(BuildContext context) {
    DateTime select;
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: Column(
        children: [
          // TableCalendar(
          //   // firstDay: DateTime.utc(1910, 09, 24),
          //   // lastDay: DateTime.utc(2100,09,24),
          //   // focusedDay: DateTime.now(),
          //   // calendarFormat: CalendarFormat.twoWeeks,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Today's Events",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          ),
                          Text("CSE 442 Demo"),
                          Text("Anime Monday"),
                          Text("Gym"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Event Invites",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          ),
                          Text("Max's Birthday Party"),
                          Text("Checkup: Dr. Wildon"),
                          Text("Family Vacation"),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),

      bottomNavigationBar: NavigationBar(selectedIndex: 2),
    );
  }
}
///Bottom navigation bar. Also, ignore from line 52 cause it needs a constructor
///that changes with click.:
// bottomNavigationBar: BottomNavigationBar(
// items: const <BottomNavigationBarItem>[
// BottomNavigationBarItem(
// icon: Icon(Icons.calendar_today_outlined),
// label: 'My Calendar',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.event_available_outlined),
// label: 'My Events',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.settings),
// label: 'Settings',
// ),
// ],
// currentIndex: _selectedIndex,
// selectedItemColor: Colors.blue,
// onTap: _onItemTapped,
// ),
