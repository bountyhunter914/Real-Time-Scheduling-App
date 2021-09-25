import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';

/// Paul's Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Feel free to change the background color.
       * It is just to help understand which page you are on while implementing your page**/
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      /** Implement your page in body. Just make sure you leave the NavigationBar**/
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              ElevatedButton(onPressed: (){
              }, child: const Text("Light/Dark Mode")
              ),

              ElevatedButton(onPressed: (){
              }, child: const Text("User: John Smith")
              ),

              ElevatedButton(onPressed: (){
              }, child: const Text("Location Services")
              ),

              ElevatedButton(onPressed: (){
              }, child: const Text("Sign out")
              ),

              ElevatedButton(onPressed: (){
              }, child: const Text("Contact us")
              ),
            ],
          ),
      ),
      bottomNavigationBar: const NavigationBar(),
      /** alignment: Alignment.bottomCenter,
          child: NavigationBar()), **/
    );
  }
}
