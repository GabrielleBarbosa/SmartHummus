import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:smarthummusapp/cards/feed_card.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
              ),
              child: Container(
                color: Color.fromRGBO(17, 204, 199, 83.0),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 70.0, left: 50.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "OLÁ,",
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                            )

                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "USUARIO",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ])
                  ),
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
                  style: TextStyle(
                      color: Color.fromRGBO(107, 107, 107, 100.0),
                      fontSize: 25),
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
