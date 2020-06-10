import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComposterScreen extends StatefulWidget {
  @override
  _ComposterScreenState createState() => _ComposterScreenState();
}

class _ComposterScreenState extends State<ComposterScreen> {

  final List<Widget> myTabs = <Widget>[
    Tab(icon: Icon(Icons.add, size: 35.0,)),
    Tab(icon: Icon(Icons.add, size: 35.0)),
    Tab(icon: Icon(Icons.add, size: 35.0))
  ];

  final List<Color> _colors = [Colors.grey, Colors.lightBlue, Colors.orange];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              onTap: (index){
                setState(() {
                  _selectedItem = index;
                });
              },
              labelPadding: EdgeInsets.only(top: 15.0),
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 35.0),
              indicatorColor:  _colors[_selectedItem],
              unselectedLabelColor: Color.fromRGBO(190, 190, 190, 100.0),
              labelColor: _colors[_selectedItem],
              tabs: myTabs,
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'MINHA COMPOSTEIRA',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(10, 10, 10, 100.0),
                ),
              ),
            )
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
