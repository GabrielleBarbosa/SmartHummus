import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComposterScreen extends StatelessWidget {
  final List<Widget> myTabs = <Widget>[
    Tab(text: 'LEFT', icon: Icon(Icons.monetization_on)),
    Tab(text: 'RIGHT', icon: Icon(Icons.add_shopping_cart)),
    Tab(text: 'RIGHT', icon: Icon(Icons.add_shopping_cart))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.orange,
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: Text('MINHA COMPOSTEIRA',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(10, 10, 10, 100.0),
              ),
          ),
        ),
        body: TabBarView(
          children: [
            new Container(
              color: Colors.deepOrangeAccent,
              child: new Center(
                child: new Text(
                  "Primeira Guia",
                  style: TextStyle(),
                ),
              ),
            ),
            new Container(
              color: Colors.blueGrey,
              child: new Center(
                child: new Text(
                  "Segunda guia",
                  style: TextStyle(),
                ),
              ),
            ),
            new Container(
              color: Colors.teal,
              child: new Center(
                child: new Text(
                  "Terceira guia",
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
