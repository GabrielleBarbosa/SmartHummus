import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chaart_card.dart';
import 'package:smarthummusapp/cards/chart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/chart_content.dart';
import 'package:smarthummusapp/database/measures.dart';

class GasesScreen extends StatefulWidget {
  List<List<Measures>> _measures;
  Measures _now;

  GasesScreen(this._measures, this._now);

  @override
  _GasesScreenState createState() => _GasesScreenState(this._measures, this._now);
}

class _GasesScreenState extends State<GasesScreen> {
  List<List<Measures>> _measures;
  Measures _now;

  _GasesScreenState(this._measures, this._now);

  double flammableValue = 0.4;

  List<List<ChartContent>> gasMQ135;
  List<List<ChartContent>> gasMQ2;

  List<Map<String, dynamic>> _warnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makeChartArrays();
    _makeWarnings();
  }

  void _makeWarnings() {
    _warnings = List<Map<String, dynamic>>();

    _warnings.add({'warning' : "Tudo certo!", 'type' : 0});
    _warnings.add({'warning' : "Tudo certo!", 'type' : 0});
  }

  void _makeChartArrays() {
    gasMQ2 = List<List<ChartContent>>();
    gasMQ135 = List<List<ChartContent>>();
    var aux1 = List<ChartContent>();
    var aux2 = List<ChartContent>();

    for (var m in _measures[0]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ2));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ135));
    }
    gasMQ2.add(aux1);
    gasMQ135.add(aux2);
    aux1 = List<ChartContent>();
    aux2 = List<ChartContent>();

    for (var m in _measures[1]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ2));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ135));
    }
    gasMQ2.add(aux1);
    gasMQ135.add(aux2);
    aux1 = List<ChartContent>();
    aux2 = List<ChartContent>();

    for (var m in _measures[2]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ2));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.gasMQ135));
    }
    gasMQ2.add(aux1);
    gasMQ135.add(aux2);
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
              "GASES",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(10, 10, 10, 100.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width / 2.3,
                lineHeight: 23.0,
                percent: flammableValue,
                backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                progressColor: Color.fromRGBO(161, 17, 245, 100.0),
                leading: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    "Gás carbônico",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            ChaartsCard(gasMQ2, "", Color(0xffc471ed), Color(0xff12c2e9)),

            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width / 2.3,
                lineHeight: 23.0,
                percent: flammableValue,
                backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                progressColor: Color.fromRGBO(161, 17, 245, 100.0),
                leading: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    "Gás metano",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            ChaartsCard(gasMQ135, "", Color(0xffc471ed), Color(0xff12c2e9)),
            WarningsCard(_warnings)
          ],
        ),
      )),
    );
  }
}
