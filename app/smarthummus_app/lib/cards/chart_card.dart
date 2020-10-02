import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartCard extends StatefulWidget {

  List<double> valores;

  ChartCard(this.valores);

  @override
  _ChartCardState createState() => _ChartCardState(this.valores);
}

class _ChartCardState extends State<ChartCard> {
  String dropdownValue = "ÚLTIMAS 24 HORAS";
  List<double> valores;

  _ChartCardState(this.valores);

  List<FlSpot> allSpots = List<FlSpot>();

  List<LineChartBarData> lineBarsData = List<LineChartBarData>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    num i = 1.0;
    for(num val in valores){
      allSpots.add(FlSpot(i, val));
      i++;
    }

    lineBarsData = [
      LineChartBarData(
          spots: allSpots,
          isCurved: true,
          barWidth: 4,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            const Color(0xff12c2e9),
            const Color(0xffc471ed),
            const Color(0xfff64f59),
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 30.0, right: 20.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(110, 110, 110, 200.0), spreadRadius: 0, blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("ATIVIDADE", style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(10, 10, 10, 100.0),
                        ),),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 20,
                          style: TextStyle(
                              color: Color.fromRGBO(10, 10, 10, 100.0)),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['ÚLTIMAS 24 HORAS', 'ÚLTIMOS 7 DIAS','ÚLTIMO MÊS']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.raleway(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    LineChart(
                      LineChartData(
                        // read about it in the below section
                        lineBarsData: lineBarsData
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}
