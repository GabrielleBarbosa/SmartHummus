import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chaart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/chart_content.dart';
import 'package:smarthummusapp/database/measures.dart';

class TemperatureScreen extends StatefulWidget {
  List<List<Measures>> _measures;
  Measures _now;

  TemperatureScreen(this._measures, this._now);

  @override
  _TemperatureScreenState createState() =>
      _TemperatureScreenState(_measures, _now);
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  List<List<Measures>> _measures;
  Measures _now;

  _TemperatureScreenState(this._measures, this._now);

  String dropdownValue = "Celsius";
  String t1 = "",  t2 = "";

  List<List<ChartContent>> tempA, tempB;

  List<Map<String, dynamic>> _warnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t1 = _now.tempA.toInt().toString() + "°C";
    t2 = _now.tempB.toInt().toString() + "°C";

    _makeChartArrays();
    _makeWarnings();
  }

  void _makeWarnings() {
    _warnings = List<Map<String, dynamic>>();
    if (_now.tempA < 13) {
      _warnings.add({
        'warning': "A temperatura da camada \"A\" está um pouco baixa, o que pode deixar as minhocas em estado de dormência."
            " Se você estiver em período de inverno pode ser normal, mas "
            "se for possível, deixe a caixa no sol por cinco minutos, para dar uma esquentada!",
        'type': 1
      });
    } else if(_now.tempA > 13 && _now.tempA < 30) {
      _warnings.add({
        'warning': "A temperatura da camada \"A\" está ideal!",
        'type': 0
      });
    }
    else if(_now.tempA > 30 && _now.tempA < 40) {
      _warnings.add({
        'warning': "A temperatura da camada \"A\" está um pouco elevada, o que pode estimular uma reprodução muito rápida nas minhocas, "
            "se a composteira estiver em um lugar que pegue muito sol, mova-a para um lugar mais sombreado. Se já estiver assim,"
            " deixe-a aberta por uns dez minutos para refrescar!",
        'type': 1
      });
    } else {
      _warnings.add({
        'warning': "A umidade da camada \"A\" está alta demais, o que pode estimular uma reprodução muito rápida nas minhocas, "
            "se a composteira estiver em um lugar que pegue muito sol, mova-a para um lugar mais sombreado. Se já estiver assim,"
            " deixe-a aberta por uns vinte minutos para refrescar!",
        'type': 2
      });
    }

    if (_now.tempB < 13) {
      _warnings.add({
        'warning': "A temperatura da camada \"B\" está um pouco baixa, o que pode deixar as minhocas em estado de dormência."
            " Se você estiver em período de inverno pode ser normal, mas "
            "se for possível, deixe a caixa no sol por cinco minutos, para dar uma esquentada!",
        'type': 1
      });
    } else if(_now.tempB > 13 && _now.tempB < 30) {
      _warnings.add({
        'warning': "A temperatura da camada \"B\" está ideal!",
        'type': 0
      });
    }
    else if(_now.tempB > 30 && _now.tempB < 40) {
      _warnings.add({
        'warning': "A temperatura da camada \"B\" está um pouco elevada, o que pode estimular uma reprodução muito rápida nas minhocas, "
            "se a composteira estiver em um lugar que pegue muito sol, mova-a para um lugar mais sombreado. Se já estiver assim,"
            " deixe-a aberta por uns dez minutos para refrescar!",
        'type': 1
      });
    } else {
      _warnings.add({
        'warning': "A umidade da camada \"B\" está alta demais, o que pode estimular uma reprodução muito rápida nas minhocas, "
            "se a composteira estiver em um lugar que pegue muito sol, mova-a para um lugar mais sombreado. Se já estiver assim,"
            " deixe-a aberta por uns vinte minutos para refrescar!",
        'type': 2
      });
    }
  }

  void _makeChartArrays() {
    tempA = List<List<ChartContent>>();
    tempB = List<List<ChartContent>>();
    var aux1 = List<ChartContent>();
    var aux2 = List<ChartContent>();
    for (var m in _measures[0]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempB));
    }
    tempA.add(aux1);
    tempB.add(aux2);
    aux1 = List<ChartContent>();
    aux2 = List<ChartContent>();

    for (var m in _measures[1]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempB));
    }
    tempA.add(aux1);
    tempB.add(aux2);
    aux1 = List<ChartContent>();
    aux2 = List<ChartContent>();

    for (var m in _measures[2]) {
      aux1.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempA));
      aux2.add(ChartContent(
          int.parse((m.date.split(' ')[4]).split(':')[0]), m.tempB));
    }
    tempA.add(aux1);
    tempB.add(aux2);
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
          Row(
            children: [
              Text(
                "TEMPERATURA",
                style: GoogleFonts.raleway(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(10, 10, 10, 100.0),
                ),
              ),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 20,
                  style: TextStyle(color: Color.fromRGBO(10, 10, 10, 100.0)),
                  onChanged: (String newValue) {
                    double convert1 = _now.tempA;
                    double convert2 = _now.tempB;
                    switch (newValue) {
                      case "Celsius":
                        setState(() {
                          t1 = convert1.toInt().toString() + "°C";
                          t2 = convert1.toInt().toString() + "°C";
                        });
                        break;
                      case "Fahreinheit":
                        convert1 = (convert1 * 9 / 5) + 32;
                        convert2 = (convert2 * 9 / 5) + 32;
                        setState(() {
                          t1 = convert1.toInt().toString() + "°F";
                          t2 = convert2.toInt().toString() + "°F";
                        });
                        break;
                      case "Kelvin":
                        convert1 += 273;
                        convert2 += 273;
                        setState(() {
                          t1 = convert1.toInt().toString() + "K";
                          t2 = convert2.toInt().toString() + "K";
                        });
                        break;
                    }
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Celsius', 'Fahreinheit', 'Kelvin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.8,
              lineHeight: 23.0,
              percent: 0.3,
              backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
              progressColor: Colors.orangeAccent,
              leading: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: new Text(
                  t1,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          ChaartsCard(tempA, "°C", Colors.orangeAccent, Colors.red),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.8,
              lineHeight: 23.0,
              percent: 0.3,
              backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
              progressColor: Colors.orangeAccent,
              leading: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: new Text(
                  t2,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          ChaartsCard(tempB, "°C", Colors.orangeAccent, Colors.red),
          WarningsCard(_warnings)
        ],
      ),
    )));
  }
}
