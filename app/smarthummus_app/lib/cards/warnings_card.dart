import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class WarningsCard extends StatefulWidget {

  List<Map<String, dynamic>> warnings;

  WarningsCard(this.warnings);

  @override
  _WarningsCardState createState() => _WarningsCardState();
}

class _WarningsCardState extends State<WarningsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 30.0, right: 20.0, bottom: 20.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "ATENÇÃO",
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(10, 10, 10, 100.0),
                        ),
                      ),
                    ),

                    _Card((widget.warnings[0])['warning'],
                        (widget.warnings[0])['type']),
                    _Card((widget.warnings[1])['warning'],
                        (widget.warnings[1])['type']),
                  ],
                ),
              ),
            )));
  }
}

class _Card extends StatelessWidget {
  _Card(this.message, this.icon);

  final String message;
  final int icon;
  final icons = [
    Icon(SmartHummusIcons.alright, color: Color.fromRGBO(211, 255, 0, 5.0),
        size: 30),
    Icon(SmartHummusIcons.alert, color: Color.fromRGBO(255, 221, 0, 5.0),
        size: 30),
    Icon(SmartHummusIcons.problem, color: Color.fromRGBO(255, 118, 0, 5.0),
        size: 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(right: 10.0, top: 10.0),
      child:
      Container(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(226, 233, 235, 100.0),
              child: Row(children: [
                icons[icon],
                VerticalDivider(color: Colors.black),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    child:  Text(
                      message,
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(40, 40, 40, 100.0),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                )
              ]),
            )),


      ),
    );
  }
}
