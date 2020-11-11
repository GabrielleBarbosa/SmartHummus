import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/news/measures.dart';
import 'package:smarthummusapp/news/news_article.dart';
import 'package:smarthummusapp/news/web_service.dart';
import 'package:smarthummusapp/screens/humidity_screen.dart';
import 'package:smarthummusapp/screens/progress_screen.dart';
import 'package:smarthummusapp/screens/temperature_screen.dart';
import 'package:http/http.dart' as http;

import 'gases_screen.dart';

class ComposterScreen extends StatefulWidget {
  @override
  _ComposterScreenState createState() => _ComposterScreenState();
}

class _ComposterScreenState extends State<ComposterScreen> {

  final List<Widget> myTabs = <Widget>[
    Tab(icon: Icon(SmartHummusIcons.leaf, size: 20.0)),
    Tab(icon: Icon(SmartHummusIcons.water, size: 30.0)),
    Tab(icon: Icon(SmartHummusIcons.thermometer, size: 30.0)),
    Tab(icon: Icon(SmartHummusIcons.gas, size: 30.0,)),
  ];

  final List<Color> _colors = [Color.fromRGBO(143, 255, 0, 100.0), Color.fromRGBO(0, 179, 224, 100.0), Color.fromRGBO(255, 118, 0, 100.0), Color.fromRGBO(161, 17, 245, 100.0)];
  int _selectedItem = 0;

  Future<List<Measures>> _measuresLastDay;

  @override
  void initState() {
    super.initState();
    _measuresLastDay = fetchMeasures();
  }

  Future<List<Measures>> fetchMeasures() async {
    String uid = await Database.getUserUid();

    final response = await http.get('https://smarthummus.herokuapp.com/medidas/dia?uid=$uid');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Measures> list = List();
      var decoded = jsonDecode(response.body);
      for(var a in decoded){
        list.add(Measures.fromJson(a));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load measures');
    }
  }

  /*void _populateMeasures() async{

    Webservice().load(await Measures.allLastDay).then((measures) => {
      setState(() => {
        _measuresLastDay = measures
      })

    });
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              onTap: (index){
                setState(() {
                  _selectedItem = index;
                });
              },
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 25.0),
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
        body: FutureBuilder<List<Measures>>(
          future: _measuresLastDay,
          builder: (context, snapshot){

            if(snapshot.hasData){
              return TabBarView(
                children: [
                  ProgressScreen(),
                  HumidityScreen(snapshot.data),
                  TemperatureScreen(snapshot.data),
                  GasesScreen(snapshot.data),
                ],
              );
            }
            else if(snapshot.hasError){
              Text("Ocorreu um erro ao carregar dados");
            }
            return CircularProgressIndicator();
          },
        )

      ),
    );
  }
}
