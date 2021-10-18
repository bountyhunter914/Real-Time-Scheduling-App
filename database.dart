import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


const dbName = 'eventsDatabase.db';
const dbVersion = 1;
const tableName = 'localEvents';
const columnID = '_id';
const columnEvents = 'Event';
const columnDate = 'Date';
const columnEventTitle = 'Title';

class Entry {
  int id;
  String event;
  String date;
  String title;
  Entry();
  Entry.fromMap(Map<String,dynamic> map) {
    id = map[columnID];
    event = map[columnEvents];
    date = map[columnDate];
    title = map[columnEventTitle];
  }

  Map<String, dynamic> toMap() {
    var map = <String,dynamic>{
      columnEvents: event,
      columnDate: date,
      columnEventTitle: title
    };
    if (id != null){
      map[columnID] = id;
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
          CREATE TABLE $tableName (
            $columnID INTEGER PRIMARY KEY,
            $columnEvents TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnEventTitle TEXT NOT NULL
          )
    ''');
  }

  Future<int> insert(Entry entry) async {
    Database db = await instance.database;
    return await db.insert(tableName, entry.toMap());
  }
  Future<List<Map<String,dynamic>>> queryAll() async {
    Database db = await instance.database;
    return db.query(tableName);
  }
}