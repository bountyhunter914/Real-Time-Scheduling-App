import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


const dbName = 'eventsDatabase.db';
const dbVersion = 1;
const tableName = 'localEvents';
const columnEventID = '_id';
const columnSettingID = '_id';

// String title;
// int year;
// int month;
// int day;
// int hour;
// int minute;

const columnEventTitle = 'Title';
const columnYear = 'Year';
const columnMonth = 'Month';
const columnDay = 'Day';
const columnHour = 'Hour';
const columnMinute = 'Minute';

const tableSetting = 'settings';
const columnUsername = 'Username';
const columnName = 'Name';
const columnTheme = 'Theme';
const columnOffline = 'Offline';


class SettingEntry {
  int id;
  String username;
  String name;
  String theme;
  String offline;
  SettingEntry();
  SettingEntry.fromMap(Map<String,dynamic> map) {
    id = map[columnSettingID];
    username = map[columnEventTitle];
    name = map[columnName];
    theme = map[columnTheme];
    offline = map[columnOffline];
  }

  Map<String, dynamic> toMap() {
    var map = <String,dynamic>{
      columnUsername: username,
      columnName: name,
      columnTheme: theme,
      columnOffline: offline,
    };
    if (id != null){
      map[columnSettingID] = id;
    }
    return map;
  }
}





class EventEntry {
  int id;
  String title;
  int year;
  int month;
  int day;
  int hour;
  int minute;
  EventEntry();
  EventEntry.fromMap(Map<String,dynamic> map) {
    id = map[columnEventID];
    title = map[columnEventTitle];
    year = map[columnYear];
    month = map[columnMonth];
    day = map[columnDay];
    hour = map[columnHour];
    minute = map[columnMinute];
  }

  Map<String, dynamic> toMap() {
    var map = <String,dynamic>{
      columnEventTitle: title,
      columnYear: year,
      columnMonth: month,
      columnDay: day,
      columnHour: hour,
      columnMinute: minute,
    };
    if (id != null){
      map[columnEventID] = id;
    }
    return map;
  }
}

class DatabaseHelper {

  //Making class singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initiateDataBase();
    return _database;
  }

  _initiateDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,dbName);
    return await openDatabase(
        path,
        version: dbVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableSetting (
            $columnSettingID INTEGER PRIMARY KEY,
            $columnUsername TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnTheme TEXT NOT NULL,
            $columnOffline TEXT NOT NULL
          )
    ''');
    await db.execute('''
          CREATE TABLE $tableName (
            $columnEventID INTEGER PRIMARY KEY,
            $columnEventTitle TEXT NOT NULL,
            $columnYear TEXT NOT NULL,
            $columnMonth TEXT NOT NULL,
            $columnDay TEXT NOT NULL,
            $columnHour TEXT NOT NULL,
            $columnMinute TEXT NOT NULL
          )
    ''');
  }

  Future<int> event_insert(EventEntry entry) async {
    Database db = await instance.database;
    return await db.insert(tableName, entry.toMap());
  }
  Future<List<Map<String,dynamic>>> queryEvents() async {
    Database db = await instance.database;
    return db.query(tableName);
  }
  Future<int> setting_insert(SettingEntry entry) async {
    Database db = await instance.database;
    return await db.insert(tableSetting, entry.toMap());
  }
  Future<List<Map<String,dynamic>>> querySettings() async {
    Database db = await instance.database;
    return db.query(tableSetting);
  }
  //EventInsert
  //SettingInsert
  //RemoveEvents


  //GetEvents
   //{'Title': [everything else]}
  //GetSettings
  //{'theme': true, 'offline' : true}
  //GetSpeficEvent Input Title,


}