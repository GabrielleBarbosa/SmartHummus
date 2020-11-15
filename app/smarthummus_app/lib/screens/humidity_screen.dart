import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chaart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/chart_content.dart';
import 'package:smarthummusapp/database/measures.dart';

class HumidityScreen extends StatefulWidget {

  List<List<Measures>> _measures;
  Measures _atual;

  HumidityScreen(this._measures, this._atual);

  @override
  _HumidityScreenState createState() => _HumidityScreenState(_measures, this._atual);
}

class _HumidityScreenState extends State<HumidityScreen> {

  Measures _atual;
  List<List<Measures>> _measures;
  List<List<ChartContent>> humA, humB;
  _HumidityScreenState(this._measures, this._atual);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makeChartArrays();
  }

  void _makeChartArrays() {
    humA = List<List<ChartContent>>();
    humB = List<List<ChartContent>>();
    var aux1 = List<ChartContent>();
    var aux2 = List<ChartContent>();
    for (var m in _measures[0]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humB));
    }
    humA.add(aux1);
    humB.add(aux2);
    aux1 = List();
    aux2 = List();

    for (var m in _measures[1]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humB));
    }
    humA.add(aux1);
    humB.add(aux2);
    aux1 = List();
    aux2 = List();

    for (var m in _measures[2]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.humB));
    }
    humA.add(aux1);
    humB.add(aux2);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0, left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "UMIDADE",
                  style: GoogleFonts.raleway(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(10, 10, 10, 100.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.8,
                    lineHeight: 23.0,
                    percent: _atual.humA/100,
                    backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                    progressColor: Color.fromRGBO(0, 179, 224, 100.0),
                    leading: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text((_atual.humA.toInt()).toString() + "%",
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                        ),),
                    ),
                  ),
                ),
                ChaartsCard(humA, "%", Color(0xff12c2e9), Color(0xffc471ed)),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.8,
                    lineHeight: 23.0,
                    percent: _atual.humA/100,
                    backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                    progressColor: Color.fromRGBO(0, 179, 224, 100.0),
                    leading: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text((_atual.humB.toInt()).toString() + "%",
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                        ),),
                    ),
                  ),
                ),
                ChaartsCard(humB, "%", Color(0xff12c2e9), Color(0xffc471ed)),
                WarningsCard()
              ],
            ),
          )
      ),
    );
  }
}
