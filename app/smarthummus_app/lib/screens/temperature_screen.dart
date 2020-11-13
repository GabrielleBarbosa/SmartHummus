import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/news/measures.dart';

class TemperatureScreen extends StatefulWidget {
  List<Measures> _measuresLastDay;
  Measures _now;

  TemperatureScreen(this._measuresLastDay, this._now);

  @override
  _TemperatureScreenState createState() =>
      _TemperatureScreenState(_measuresLastDay, _now);
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  List<Measures> _measuresLastDay;
  Measures _now;

  _TemperatureScreenState(this._measuresLastDay, this._now);

  String dropdownValue = "Celsius";
  String t1 = "",  t2 = "";

  List<double> values = [26.0, 27.0, 30.0, 32.0, 30.0, 28.0, 29.0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t1 = _now.tempA.toInt().toString() + "°C";
    t2 = _now.tempB.toInt().toString() + "°C";
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
          ChartCard(_measuresLastDay, "tempA", Colors.orangeAccent, Colors.red),
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
          ChartCard(_measuresLastDay, "tempB", Colors.orangeAccent, Colors.red),
          WarningsCard()
        ],
      ),
    )));
  }
}
