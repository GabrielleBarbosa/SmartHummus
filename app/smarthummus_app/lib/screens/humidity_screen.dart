import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HumidityScreen extends StatefulWidget {
  @override
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {

  double humidityValue = 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                width: 240.0,
                lineHeight: 23.0,
                percent: humidityValue,
                backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                progressColor: Color.fromRGBO(0, 179, 224, 100.0),
                leading: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text((humidityValue*100).toString() + "%",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                    ),),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
