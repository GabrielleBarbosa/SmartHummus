import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/comment_card.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: 130,
            ),
            Container(
              color: Color.fromRGBO(121, 55, 180, 1.0),
              height: 85,
            ),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image(
                          image: AssetImage("assets/images/perfil.png"),
                          fit: BoxFit.cover,
                          width: 120),
                    )))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            "Vitor Ramos",
            style: GoogleFonts.raleway(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(55, 55, 55, 0.7)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  SmartHummusIcons.star,
                  size: 15.0,
                  color: Colors.amber,
                ),
              ),
              Text(
                "4.92",
                style: GoogleFonts.righteous(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(55, 55, 55, 0.7)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  spreadRadius: 0,
                  blurRadius: 15),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
                    child: Text(
                      "ATIVIDADE",
                      style: GoogleFonts.raleway(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(55, 55, 55, 0.65)),
                    ),
                  ),
                  buildActivities(SmartHummusIcons.bag, "TEXTO",
                      Color.fromRGBO(107, 109, 255, 1.0)),
                  buildActivities(SmartHummusIcons.starman, "TEXTO",
                      Color.fromRGBO(107, 109, 255, 1.0)),
                  buildActivities(SmartHummusIcons.medal, "TEXTO",
                      Color.fromRGBO(107, 109, 255, 1.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(color: Color.fromRGBO(195, 214, 220, 100.0), thickness: 2),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 30.0, left: 35.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "AVALIAÇÕES",
                          style: GoogleFonts.raleway(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
                              color: Color.fromRGBO(55, 55, 55, 0.65)),
                        ),
                      )),
                  CommentCard("Gabrielle da Silva Barbosa".split(" ")[0], "De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo","", 3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(color: Color.fromRGBO(195, 214, 220, 100.0), thickness: 2),
                  ),
                  CommentCard("Gabrielle da Silva Barbosa".split(" ")[0], "De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo De galho em galho, o macaco enche o papo","", 1),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget buildActivities(IconData icon, String title, Color color) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0, left: 35.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                icon,
                size: 20.0,
                color: color,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.raleway(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(55, 55, 55, 0.65)),
            ),
          ],
        ));
  }
}
