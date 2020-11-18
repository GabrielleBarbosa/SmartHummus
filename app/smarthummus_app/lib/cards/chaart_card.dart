import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/chart_content.dart';
import 'package:smarthummusapp/database/measures.dart';

class ChaartsCard extends StatefulWidget {
  List<List<ChartContent>> values;
  String tipo;
  Color cor1, cor2;

  ChaartsCard(this.values, this.tipo, this.cor1, this.cor2);

  @override
  _ChaartsCardState createState() =>
      _ChaartsCardState(this.values, this.tipo, this.cor1, this.cor2);
}

class _ChaartsCardState extends State<ChaartsCard> {
  String dropdownValue = "ÚLTIMAS 24 HORAS";
  List<List<ChartContent>> values;
  String tipo;
  Color cor1, cor2;

  Map<DateTime, double> line1;
  Map<DateTime, double> line2;
  Map<DateTime, double> line3;
  LineChart chart;

  _ChaartsCardState(this.values, this.tipo, this.cor1, this.cor2);

  @override
  void initState() {
    // TODO: implement initState
    initLines();
    updateChart();
  }

  void initLines() {
    line1 = Map();
    for (int i = 0; i < values[0].length; i++) {
      line1[DateTime.now().subtract(Duration(minutes: 60 * i))] =
          (values[0])[i].y;
    }
    line2 = Map();
    for (int i = 0; i < values[1].length; i++) {
      line2[DateTime.now().subtract(Duration(minutes: 60 * i))] =
          (values[1])[i].y;
    }
    line3 = Map();
    for (int i = 0; i < values[2].length; i++) {
      line3[DateTime.now().subtract(Duration(minutes: 60 * i))] =
          (values[2])[i].y;
    }
  }

  void updateChart() {
    setState(() {
      switch(dropdownValue){
        case 'ÚLTIMAS 24 HORAS':
          chart = LineChart.fromDateTimeMaps(
              [line1], [cor1], [tipo],
              );
          break;

        case 'ÚLTIMOS 7 DIAS':
          chart = LineChart.fromDateTimeMaps(
              [line2], [cor1], [tipo],
              );
          break;

        case 'ÚLTIMO MÊS':
          chart = LineChart.fromDateTimeMaps(
              [line3], [cor1], [tipo],
              );
          break;
      }
    });
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
                BoxShadow(
                    color: Color.fromRGBO(110, 110, 110, 200.0),
                    spreadRadius: 0,
                    blurRadius: 20),
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "ATIVIDADE",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(10, 10, 10, 100.0),
                          ),
                        ),
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
                            updateChart();
                          },
                          items: <String>[
                            'ÚLTIMAS 24 HORAS',
                            'ÚLTIMOS 7 DIAS',
                            'ÚLTIMO MÊS'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
                      child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width / 2,
                          child: AnimatedLineChart(
                            chart,
                            key: UniqueKey(),
                          )

                      ),
                    )

                  ],
                ),
              ),
            )));
  }
}
