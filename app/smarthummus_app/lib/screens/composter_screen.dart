import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/humidity_screen.dart';
import 'package:smarthummusapp/screens/temperature_screen.dart';

import 'gases_screen.dart';

class ComposterScreen extends StatefulWidget {
  @override
  _ComposterScreenState createState() => _ComposterScreenState();
}

class _ComposterScreenState extends State<ComposterScreen> {

  final List<Widget> myTabs = <Widget>[
    Tab(icon: Icon(SmartHummusIcons.water, size: 35.0)),
    Tab(icon: Icon(SmartHummusIcons.thermometer, size: 35.0)),
    Tab(icon: Icon(SmartHummusIcons.gas, size: 35.0,)),
  ];

  final List<Color> _colors = [Color.fromRGBO(0, 179, 224, 100.0), Color.fromRGBO(255, 118, 0, 100.0), Color.fromRGBO(152, 189, 88, 100.0)];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              onTap: (index){
                setState(() {
                  _selectedItem = index;
                });
              },
              labelPadding: EdgeInsets.only(top: 15.0),
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 35.0),
              indicatorColor:  _colors[_selectedItem],
              unselectedLabelColor: Color.fromRGBO(190, 190, 190, 100.0),
              labelColor: _colors[_selectedItem],
              tabs: myTabs,
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'MINHA COMPOSTEIRA',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(10, 10, 10, 100.0),
                ),
              ),
            )
        ),
        body: TabBarView(
          children: [
            HumidityScreen(),
            TemperatureScreen(),
            GasesScreen(),
          ],
        ),
      ),
    );
  }
}
