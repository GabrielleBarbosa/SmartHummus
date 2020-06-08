import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smarthummusapp/screens/feed_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _page = FeedScreen();
  final color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _page,
        bottomNavigationBar: Container(
          color: color,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(Icons.add_shopping_cart)),
                  BottomNavigationBarItem(
                      title: Text(""),
                      icon: Icon(Icons.check_box_outline_blank, size: 60)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(Icons.monetization_on)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(Icons.person)),
                ],
                backgroundColor: Colors.white,
                elevation: 1200,
                type: BottomNavigationBarType.fixed,
                iconSize: 35,
                showSelectedLabels: false,
                unselectedItemColor: Colors.blueGrey,
                selectedItemColor: Colors.indigoAccent,
                showUnselectedLabels: false,
                currentIndex: _selectedindex,
                onTap: _tapped,
              ),
            )
        )
    ));
  }

  int _selectedindex = 0;
  void _tapped(int index) {
    setState(() {
      _selectedindex = index;

      switch (index) {
        case 0:
          _page = FeedScreen();
          break;

        case 1:
          _page = Container(color: Colors.blue);
          break;
      }
    });
  }
}
