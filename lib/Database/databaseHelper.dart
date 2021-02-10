import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider _instance = SQLiteDbProvider._();
  factory SQLiteDbProvider() => _instance;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  /// Initialize DB
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "MYDataBAse.db");
    var taskDb = await openDatabase(path, version: 1);
    return taskDb;
  }

  /// Count number of tables in DB
  Future countTable() async {
    var dbClient = await database;
    var res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }
}
