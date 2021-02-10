import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite_database/Database/CURDDatabase.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sqlite_database/Database/CustomerInfo.dart';

const APIDATA =
    'https://esnep.com/easyCollectorR/api/Collector/CollectorList?CoOperativeCode=ES25';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List apiData;
  Map jsonData;
  Future getData() async {
    http.Response response = await http.get('$APIDATA');
    jsonData = jsonDecode(response.body);
    setState(() {
      apiData = jsonData['LstCollector'];
    });
    delete();
    for (int i = 0; i < apiData.length; i++) {
      String name = apiData[i]['FullName'];
      String id = apiData[i]['\$id'];
      String coOperativeCode = apiData[i]['CoOperativeCode'];
      String collectorID = apiData[i]['CollectorID'];
      String collectorImg = apiData[i]['CollectorImg'];
      insertUser(name, id, coOperativeCode, collectorID, collectorImg);
    }
  }

  checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      getData();
      getDataFromDb();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      getData();
      getDataFromDb();
    } else {
      getDataFromDb();
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    // createUserTable();
    // // checkInternetConnectivity();
    // getData();
    // // getAll();
    // getDataFromDb();
  }

  List<CustomerInfo> list = List();
  Future getDataFromDb() async {
    List<CustomerInfo> info = await getCustomerList();
    for (int i = 0; i < info.length; i++) {
      String name = info[i].name;
      String id = info[i].id;
      String coOperativeCode = info[i].coOperativeCode;
      String collectorImg = info[i].collectorImg;
      String collectorID = info[i].collectorID;
      list.add(CustomerInfo(
          name: name,
          id: id,
          coOperativeCode: coOperativeCode,
          collectorImg: collectorImg,
          collectorID: collectorID));
      print(name);
      print(id);
      print(coOperativeCode);
      print(collectorImg);
      print(collectorID);
    }
    // ListView.builder(
    //     itemCount: info.length,
    //     padding: const EdgeInsets.all(15.0),
    //     itemBuilder: (context, position) {
    //       return Column(children: <Widget>[
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //           Expanded(child: Text('${info[position].coOperativeCode}')),
    //           Expanded(child: Text('${info[position].name}')),
    //           Expanded(child: Text('${info[position].collectorImg}')),
    //         ]),
    //       ]);
    //     });
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Container(
      padding: EdgeInsets.all(11.0),
      color: Colors.cyan[300],
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Co-Operative ID'),
        Text('Name'),
        Text('Collector Image'),
      ]),
    );
    Widget userData = Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Text('${list[position].coOperativeCode}')),
                Expanded(child: Text('${list[position].name}')),
                Expanded(child: Text('${list[position].collectorImg}')),
              ]),
            ]);
          }),
      // child: FutureBuilder(
      //     //fetching data from db
      //     future: getDataFromDb.call(),
      //     builder: (context, AsyncSnapshot snapshot) {
      //       if (!snapshot.hasData) {
      //         //loading circular progress bar
      //         return Center(child: CircularProgressIndicator());
      //       } else {
      //         return Container(
      //           child: ListView.builder(
      //               itemCount: {snapshot.data}.length,
      //               // itemCount: list.length,
      //               // itemCount: info.toString().length,
      //               scrollDirection: Axis.vertical,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return Column(children: [
      //                   //custom widget
      //                   Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Expanded(
      //                             child: Text(
      //                                 '${snapshot.data[index].coOperativeCode.toString()}')),
      //                         Expanded(
      //                             child: Text(
      //                                 '${snapshot.data[index].name.toString()}')),
      //                         Expanded(
      //                             child: Text(
      //                                 '${snapshot.data[index].collectorImg.toString()}')),
      //                       ]),
      //                   // positionedBlock(context, snapshot.data[index]),
      //                   Divider(
      //                     thickness: 2,
      //                   ),
      //                 ]);
      //               }),
      //         );
      //       }
      //     }),
    );
    // Widget bottomNavigation = BottomNavigationBar();
    // RaisedButton(onPressed: () {}, child: Text('Save'))],
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Hello World')),
        body: ListView(
          children: [
            header,
            userData,
            // Text('The number of list is' + getCount().toString()),
            // bottomNavigation,
          ],
        ),
      ),
    );
  }
}
