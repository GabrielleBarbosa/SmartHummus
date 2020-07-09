import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double progress = 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "STATUS",
                style: GoogleFonts.raleway(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(10, 10, 10, 100.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: CircularPercentIndicator(
                  radius: 200.0,
                  lineWidth: 15.0,
                  percent: progress,
                  backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
                  progressColor: Color.fromRGBO(143, 255, 0, 100.0),
                  footer: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text((progress*100).toString() + "%",
                            style: GoogleFonts.raleway(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Aproximadamente " + (30 - progress*30).toInt().toString() + "\ndias até ficar pronto",
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ],
                  ),
                  center: Image(
                    image: AssetImage('assets/images/leaf_progress.png'),
                    width: 150,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
