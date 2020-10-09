import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/measures.dart';


class ChartCard extends StatefulWidget {

  List<Measures> valores;
  String tipo;
  Color cor1, cor2;

  ChartCard(this.valores, this.tipo, this.cor1, this.cor2);

  @override
  _ChartCardState createState() => _ChartCardState(this.valores, this.tipo, this.cor1, this.cor2);
}

class _ChartCardState extends State<ChartCard> {
  String dropdownValue = "ÚLTIMAS 24 HORAS";
  List<Measures> valores;
  String tipo;
  Color cor1, cor2;

  _ChartCardState(this.valores, this.tipo, this.cor1, this.cor2);

  List<FlSpot> allSpots = List<FlSpot>();

  List<LineChartBarData> lineBarsData = List<LineChartBarData>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    num i = 1.0;
    for(Measures mer in valores){
      switch(tipo){
        case "tempA":
          allSpots.add(FlSpot(i, mer.tempA));
          break;
        case "tempB":
          allSpots.add(FlSpot(i, mer.tempB));
          break;
        case "humA":
          allSpots.add(FlSpot(i, mer.humA));
          break;
        case "humB":
          allSpots.add(FlSpot(i, mer.humB));
          break;
        case "gasMQ2":
          allSpots.add(FlSpot(i, mer.gasMQ2));
          break;
        case "gasMQ135":
          allSpots.add(FlSpot(i, mer.gasMQ135));
          break;
      }

      i++;
    }

    lineBarsData = [
      LineChartBarData(
          spots: allSpots,
          isCurved: true,
          barWidth: 2,
          belowBarData: BarAreaData(
            show: true,
            colors: [
              cor1.withOpacity(0.4),
              cor2.withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            cor1,
            cor2,
          ],
          colorStops: [
            0.2,
            0.8,
          ],

      ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: LineChart(
                        LineChartData(
                          // read about it in the below section
                            lineBarsData: lineBarsData,
                            titlesData: FlTitlesData(leftTitles: SideTitles(
                                interval: 5,
                                showTitles: true))

                        ),
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
