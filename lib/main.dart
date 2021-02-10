import 'package:flutter/material.dart';
import 'package:sqlite_database/Database/databaseHelper.dart';
import 'package:sqlite_database/Demo/helper.dart';
import 'package:sqlite_database/index.dart';
import 'package:sqlite_database/networkhelper.dart';
import 'package:sqlite_database/sharePreference/sharePreference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize sq-lite
  final db = SQLiteDbProvider();
  await db.countTable();

  /// Runs the app
  return runApp(MaterialApp(home: MyApp()));
  // return runApp(MaterialApp(home: FlutterDemo(storage: CounterStorage())));
}
