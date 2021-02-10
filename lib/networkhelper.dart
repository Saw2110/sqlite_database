import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkConnection extends StatefulWidget {
  @override
  _NetworkConnectionState createState() => _NetworkConnectionState();
}

class _NetworkConnectionState extends State<NetworkConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Check Connection'),
          onPressed: _checkInternetConnectivity,
        ),
      ),
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('no internet connection'),
            );
          });
    }
    if (result == ConnectivityResult.mobile) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('internet connection through mobile'),
            );
          });
    }
    if (result == ConnectivityResult.wifi) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('internet connection through wifi'),
            );
          });
    }
  }
}
