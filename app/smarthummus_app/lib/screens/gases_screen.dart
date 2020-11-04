import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chart_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/measures.dart';

class GasesScreen extends StatefulWidget {
  @override
  _GasesScreenState createState() => _GasesScreenState();
}

class _GasesScreenState extends State<GasesScreen> {
  double flammableValue = 0.4;
  List<double> values = [40, 50, 30, 40, 45, 55];

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
                    "Inflamáveis",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
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
                  return Column(
                    children: [
                      ChartCard(measures.data, "gasMQ2", Color(0xff12c2e9),
                          Color(0xffc471ed)),
                      ChartCard(measures.data, "gasMQ135", Color(0xff12c2e9),
                          Color(0xffc471ed))
                    ],
                  );
                }
              },
            ),
            WarningsCard()
          ],
        ),
      )),
    );
  }
}
