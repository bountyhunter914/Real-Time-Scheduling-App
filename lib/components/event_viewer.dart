import 'package:flutter/material.dart';
import 'package:real_time_scheduling/database.dart';

class EventView extends StatelessWidget {
  EventView({Key? key}) : super(key: key);
  final List<Map<String,dynamic>> data = getData() as List<Map<String, dynamic>>;
  late final sortedData = sortData(data);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var i in data) eventMaker(i[0], i[1])
      ],
    );
  }
}
Future<List<Map<String, dynamic>>> getData() async {
  return await DatabaseHelper.instance.queryAll();
}

List<List<String>> sortData(List<Map<String,dynamic>> gdata){
  List<List<String>> sortedData = [];
  for(var i in gdata){
    sortedData.add([i['title'].toString(),i['date'].toString()]);
  }
  return sortedData;
}

Row eventMaker(String title, String date){
  return Row(
    children: [
      Text(title),
      Text("     "),
      Text(date),
    ],
  );
}