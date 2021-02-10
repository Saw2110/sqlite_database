import 'package:sqflite/sqflite.dart';
import 'package:sqlite_database/Database/databaseHelper.dart';
import 'CustomerInfo.dart';

///get no of objects in db
// Future<int> getCount() async {
//   var dbList = await SQLiteDbProvider().database;
//   List<Map<String, dynamic>> x =
//       await dbList.rawQuery('SELECT COUNT (*) from $getExerciseList');
//   int result = Sqflite.firstIntValue(x);
//   return result;
// }

///Create User Table
Future createUserTable() async {
  var dbClient = await SQLiteDbProvider().database;
  var res = await dbClient.execute(
      "CREATE TABLE if not exists User(name TEXT,id TEXT,coOperativeCode TEXT,collectorID TEXT,collectorImg TEXT)");
  return res;
}

/// Add user to the table
Future insertUser(String name, String id, String coOperativeCode,
    String collectorID, String collectorImg) async {
  // Adds user to table
  final dbClient = await SQLiteDbProvider().database;
  var res = await dbClient.execute(
      "Insert into User(name,id,collectorImg,collectorID,coOperativeCode) Values ('$name','$id','$collectorImg','$collectorID','$coOperativeCode')");
  return res;
}

///Update data using raw query
Future update(newAge, id) async {
  var dbClient = await SQLiteDbProvider().database;
  var res = await dbClient
      .rawQuery(" UPDATE User SET age = newAge WHERE id = '$id';");
  return res;
}

/// Delete data using raw query
Future delete() async {
  var dbClient = await SQLiteDbProvider().database;
  var res = await dbClient.rawQuery("DELETE FROM User");
  return res;
}

Future getAll() async {
  var dbClient = await SQLiteDbProvider().database;
  final res = await dbClient.rawQuery("SELECT * FROM User");
  return res;
}

Future<List<Map<String, dynamic>>> getCustomerMapList() async {
  var dbClient = await SQLiteDbProvider().database;
  final res = await dbClient.rawQuery("SELECT * FROM User");
  return res;
}

//get Map list from db, convert to Costumer List object
Future<List<CustomerInfo>> getCustomerList() async {
  //get map list and # of entries in db
  List<Map<String, dynamic>> customerMapList = await getCustomerMapList();
  // List<CustomerInfo> customerList = List<CustomerInfo>();
  List<CustomerInfo> customerList = List<CustomerInfo>();
  //Loop to create Customer list from a map list
  for (var entry in customerMapList) {
    customerList.add(CustomerInfo(
        name: entry['name'],
        id: entry['id'],
        collectorID: entry['collectorID'],
        collectorImg: entry['collectorImg'],
        coOperativeCode: entry['coOperativeCode']));
  }
  return customerList;
}
