import 'package:flutter/material.dart';

class FeedCard extends StatefulWidget {

  final String title, headline;

  FeedCard(this.title, this.headline);

  @override
  _FeedCardState createState() => _FeedCardState(this.title, this.headline);
}

class _FeedCardState extends State<FeedCard> {
  String title, headline;
  Image image;
  _FeedCardState(this.title, this.headline);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        child: Column(
          children: [
           Padding(
             padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
             child:  Align(
               alignment: Alignment.centerLeft,
               child: Text(title.toUpperCase(), style: TextStyle(fontSize: 20, color: Color.fromRGBO(107, 107, 107, 100.0),), textAlign: TextAlign.left,),
             ),
           ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 0),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: Container(
                    color: Color.fromRGBO(238, 244, 246, 50.0),
                    height: 200,
                  )
              ),
            )
          ],
        )
    );
  }
}

