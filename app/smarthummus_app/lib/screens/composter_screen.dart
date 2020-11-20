import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/measures.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
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

  Future<List<List<Measures>>> _measures;
  Future<Measures> _atual;
  Future<bool> _hasComposter;

  @override
  void initState() {
    super.initState();
    _hasComposter = Database.hasComposter();
    _measures = fetchMeasures();
    _atual = Database.getMeasureNow();
  }

  Future<List<List<Measures>>> fetchMeasures() async {
    var m = List<List<Measures>>();
    String uid = await Database.getUserUid();

    var response = await http.get('https://smarthummus.herokuapp.com/medidas/dia?uid=$uid');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Measures> list = List<Measures>();
      var decoded = jsonDecode(response.body);
      for(var a in decoded){
        list.add(Measures.fromJson(a));
      }
      m.add(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load measures');
    }

    response = await http.get('https://smarthummus.herokuapp.com/medidas/semana?uid=$uid');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Measures> list = List<Measures>();
      var decoded = jsonDecode(response.body);
      for(var a in decoded){
        list.add(Measures.fromJson(a));
      }
      m.add(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load measures');
    }

    response = await http.get('https://smarthummus.herokuapp.com/medidas/mes?uid=$uid');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Measures> list = List<Measures>();
      var decoded = jsonDecode(response.body);
      for(var a in decoded){
        list.add(Measures.fromJson(a));
      }
      m.add(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load measures');
    }
    return m;
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
    return FutureBuilder<bool>(
      future: _hasComposter,
      builder: (context, snapshot){
        if(snapshot.hasData)
          return snapshot.data ? buildScreenWithComposter() : buildScreenWithoutComposter();
        else if (snapshot.hasError)
          return Text("Ocorreu um erro ao carregar dados");
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildScreenWithComposter(){
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
          body: FutureBuilder<List<List<Measures>>>(
            future: _measures,
            builder: (context, snapshot){

              if(snapshot.hasData){
                return FutureBuilder<Measures>(
                  future: _atual,
                  builder: (context, snapshot2){
                    if(snapshot2.hasData)
                      return TabBarView(
                        children: [
                          ProgressScreen(true),
                          HumidityScreen(snapshot.data, snapshot2.data),
                          TemperatureScreen(snapshot.data, snapshot2.data),
                          GasesScreen(snapshot.data),
                        ],
                      );
                    else if(snapshot2.hasError){
                      return Text(snapshot2.error.toString());
                    }
                    return CircularProgressIndicator();
                  },
                );
              }
              else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
            },
          )
      ),
    );
  }

  Widget buildScreenWithoutComposter(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 10),
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
      body:  ProgressScreen(false)
    );
  }
}
