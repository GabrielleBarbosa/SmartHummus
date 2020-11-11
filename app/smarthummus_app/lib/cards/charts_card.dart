import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/news/measures.dart';

class ChartsCard extends StatefulWidget {
  List<Measures> valores;
  String tipo;
  Color cor1, cor2;

  ChartsCard(this.valores, this.tipo, this.cor1, this.cor2);

  @override
  _ChartsCardState createState() =>
      _ChartsCardState(this.valores, this.tipo, this.cor1, this.cor2);
}

class _ChartsCardState extends State<ChartsCard> {
  String dropdownValue = "ÚLTIMAS 24 HORAS";
  List<Measures> valores;
  String tipo;
  Color cor1, cor2;

  Map<DateTime, double> line1;
  Map<DateTime, double> line2;
  Map<DateTime, double> line3;
  AreaLineChart chart;

  _ChartsCardState(this.valores, this.tipo, this.cor1, this.cor2);

  @override
  void initState() {
    // TODO: implement initState
    initLines();
    updateChart();
  }

  void initLines() {
    line1 = Map();
    for (int i = 0; i < valores.length; i++) {
      line1[DateTime.now().subtract(Duration(minutes: 60 * i))] =
          valores[i].humA;
    }
  }

  void updateChart() {
    setState(() {
      switch(dropdownValue){
        case 'ÚLTIMAS 24 HORAS':
          chart = AreaLineChart.fromDateTimeMaps(
              [line1], [cor1], ['%'],
              gradients: [Pair(cor1.withOpacity(0.5), cor2.withOpacity(0.5))]);
          break;

        case 'ÚLTIMOS 7 DIAS':
          chart = AreaLineChart.fromDateTimeMaps(
              [line2], [cor1], ['%'],
              gradients: [Pair(cor1.withOpacity(0.5), cor2.withOpacity(0.5))]);
          break;

        case 'ÚLTIMO MÊS':
          chart = AreaLineChart.fromDateTimeMaps(
              [line1], [cor1], ['%'],
              gradients: [Pair(cor1.withOpacity(0.5), cor2.withOpacity(0.5))]);
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
