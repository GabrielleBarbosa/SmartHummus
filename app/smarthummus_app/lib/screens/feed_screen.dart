import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:smarthummusapp/cards/feed_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          color: Colors.transparent,
          height: 180,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(55.0),
                bottomLeft: Radius.circular(55.0),
              ),
              child: Container(
                color: Color.fromRGBO(17, 204, 199, 83.0),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 70.0, left: 35.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "OLÁ,",
                                  style: GoogleFonts.raleway(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "USUARIO",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ])),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Image(
                        image: AssetImage('assets/images/folhas.png'),
                        fit: BoxFit.cover,
                        width: 230,)
                ]),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: Text(
                  "FEED",
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(55, 55, 55, 100.0)
                  ),
                  textAlign: TextAlign.center,
                )),
            FeedCard("Notícias", "Meio Ambiente"),
            FeedCard("Notícias", "Meio Ambiente"),
            FeedCard("Notícias", "Meio Ambiente")
          ],
        ),
      ],
    ));
  }
}
