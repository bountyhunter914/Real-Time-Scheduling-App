import 'package:flutter/material.dart';
import 'package:real_time_scheduling/navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs();
  //static const mail = 'mailto:sluggishschedulers@gmail.com?subject=ContactUs&body=New%20plugin';
  static const mail = 'http://flutter.dev';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('Contact Us'),
        ),
        /** Implement your page in body. Just make sure you leave the NavigationBar**/
        body: Center(
        child: Column(
          children: [
            Text("Having any problems?", style: TextStyle(height: 5, fontSize: 25)),
            Text("Contact us at", style: TextStyle(height: 5, fontSize: 25)),
            Text("sluggishschedulers@gmail.com", style: TextStyle(height: 5, fontSize: 20)),
            RaisedButton(
                onPressed: _sendEmail,
                child: new Text("Email Us!"),
            ),
          ],
          ),
        ),
        bottomNavigationBar: NavigationBar(selectedIndex: 3)
    );
  }
  _sendEmail() async{
    if (await canLaunch(mail)){
      await launch(mail);
    }else{
      throw "Sorry, email could not be sent";
    }
  }
}

