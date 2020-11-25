import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'discovery_page.dart';

// import './helpers/LineChart.dart';

class BluetoothApp extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<BluetoothApp> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  bool isDisconnecting = false;
  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BluetoothDevice _device;
  BluetoothConnection connection;

  TextEditingController _nameWifiController = TextEditingController();
  TextEditingController _passWifiController = TextEditingController();


  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });

    if(connection != null){
      connect();
    }
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  void connect(){
    BluetoothConnection.toAddress(_device.address).then((_connection) { 
      print('Connected to the device');
      connection = _connection;

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conexão via Bluetooth', style: GoogleFonts.raleway(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Row(
              children: [
                Text('Bluetooth'),
                Flexible(fit: FlexFit.tight, child: SizedBox(),),
                Switch(
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
                Text('ou'),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.blueAccent,),
                  color: Color.fromRGBO(124, 219, 0, 1.0),
                  onPressed: () {
                    FlutterBluetoothSerial.instance.openSettings();
                  },
                ),
              ],
            ),),
            Divider(),
            ListTile(title: const Text('Procurar a composteira\n(selecione a opção com nome HC-05)')),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Color.fromRGBO(124, 219, 0, 1.0),
                  child: Container(
                      width: 130,
                      height: 40,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: <Widget>[
                          Text("BUSCAR",
                              style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.search,
                                  color: Colors.white, size: 15.0)
                          )
                        ],
                      )),
                  onPressed: !_bluetoothState.isEnabled ? null : () async {
                    final BluetoothDevice selectedDevice =
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      setState(() {

                        _device = selectedDevice;
                      });
                      connect();
                      print('Discovery -> selected ' + selectedDevice.address);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                child: TextField(
                  controller: _nameWifiController,
                  decoration: InputDecoration(
                    labelText: 'Nome da rede WiFi doméstica',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                child: TextField(
                  controller: _passWifiController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha do WiFi',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: Color.fromRGBO(124, 219, 0, 1.0),
                child: Container(
                    width: 170,
                    height: 40,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Enviar Informações",
                            style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.send,
                                color: Colors.white, size: 15.0)
                        )
                      ],
                    )),
                onPressed: _device == null || connection == null ? null : connection.isConnected ? (){_sendMessage();} : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    print(dataString);
  }

  void _sendMessage() async {
    String name = _nameWifiController.text.trim(),
    pass = _passWifiController.text;

    if (name.length > 0 && pass.length > 0) {
      String uid = await Database.getUserUid();
      try {
        connection.output.add(utf8.encode("$name:$pass:$uid" + "\r\n"));
        await connection.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

}