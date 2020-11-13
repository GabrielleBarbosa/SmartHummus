import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/cards/chart_card.dart';
import 'package:smarthummusapp/cards/charts_card.dart';
import 'package:smarthummusapp/cards/warnings_card.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/news/measures.dart';

class HumidityScreen extends StatefulWidget {

  List<Measures> _measuresLastDay;
  Measures _atual;

  HumidityScreen(this._measuresLastDay, this._atual);

  @override
  _HumidityScreenState createState() => _HumidityScreenState(_measuresLastDay, this._atual);
}

class _HumidityScreenState extends State<HumidityScreen> {

  Measures _atual;
  List<Measures> _measuresLastDay;

  _HumidityScreenState(this._measuresLastDay, this._atual);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      child: Text((_atual.humA).toString() + "%",
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                        ),),
                    ),
                  ),
                ),
              Column(children: [ChartsCard(_measuresLastDay, "humA", Color(0xff12c2e9), Color(0xffc471ed)),ChartsCard(_measuresLastDay, "humB", Color(0xff12c2e9), Color(0xffc471ed))],),
                WarningsCard()
              ],
            ),
          )
      ),
    );
  }
}
