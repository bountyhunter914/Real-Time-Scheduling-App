
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:real_time_scheduling/ThemeModel.dart';
import 'package:real_time_scheduling/navigation_bar.dart';

class SettingsBuilder extends StatefulWidget{
  @override
  _SettingsBuilderState createState() => _SettingsBuilderState();
}

class _SettingsBuilderState extends State{
  @override
  Widget build(BuildContext context){
    return Consumer(builder: (context, ThemeModel themeNotifier, child){
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings", style: TextStyle(fontSize:22)),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(height: 80, thickness: 1),
                SizedBox(height: 15),
                buildSlider("Change Theme", themeNotifier),
                buildAccountOption(context, "Content Settings"),
                buildAccountOption(context, "Privacy"),
                buildAccountOption(context, "Sign Out"),
                buildAccountOption(context, "Contact Us"),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(selectedIndex: 3),
        );
  });
  }
  Padding buildSlider(String title, ThemeModel themeNotifier){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
          )),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.white,
              value: themeNotifier.isDark? false: true,
              onChanged: (value){
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              },
            ),
          )
        ],
      ),
    );
  }
  GestureDetector buildAccountOption(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  if(title == "Contact Us")
                    Text("Have a problem? Email us at SluggishSchedulers@gmail.com and we'll get back to you!"),
                  if(title != "Contact Us")
                  Text("Under Construction")
                ]
            ),
            actions: [

            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize:  25,
                fontWeight: FontWeight.w600,
            )),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}