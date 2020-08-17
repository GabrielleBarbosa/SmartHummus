import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {


  FlutterBlue flutterBlue = FlutterBlue.instance;

  void procurar(){
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
        var subscription = flutterBlue.scanResults.listen((results) {
          // do something with scan results
          for (ScanResult r in results) {
                print('${r.device.name} found! rssi: ${r.rssi}');
          }
        });

    // Stop scanning
    flutterBlue.stopScan();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        child: Text("Conectar"),
        onPressed: procurar,
      ),
    );
  }
}
