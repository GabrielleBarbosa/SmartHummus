import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/measures.dart';

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  String dropdownValue = "Celsius";
  double temperatureValue = 35;
  String temperatureText = "35°C";

  List<double> values = [26.0, 27.0, 30.0, 32.0, 30.0, 28.0, 29.0];

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
                  double convert = temperatureValue;
                  switch (newValue) {
                    case "Celsius":
                      setState(() {
                        temperatureText = convert.toInt().toString() + "°C";
                      });
                      break;
                    case "Fahreinheit":
                      convert = (convert * 9 / 5) + 32;
                      setState(() {
                        temperatureText = convert.toInt().toString() + "°F";
                      });
                      break;
                    case "Kelvin":
                      convert += 273;
                      setState(() {
                        temperatureText = convert.toInt().toString() + "K";
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
              width: MediaQuery.of(context).size.width / 1.6,
              lineHeight: 23.0,
              percent: 0.3,
              backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
              progressColor: Colors.orangeAccent,
              leading: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: new Text(
                  temperatureText,
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<List<Measures>>(
            future: Database.getMeasures(),
            builder: (context, measures) {
              if (!measures.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                return Column(children: [ChartCard(measures.data, "tempA", Colors.orangeAccent, Colors.red),ChartCard(measures.data, "tempB", Colors.orangeAccent, Colors.red)],);
              }
            },
          ),
          WarningsCard()
      ],
    ),)
    )
    );
  }
}
