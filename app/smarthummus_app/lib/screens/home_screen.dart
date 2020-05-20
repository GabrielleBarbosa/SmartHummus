import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.indigo
        ),
        bottomNavigationBar: Container(
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
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), title: Text('Favourite')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), title: Text('Favourite'))
                ],
              ),
            )));
  }

  int _selectedindex = 0;
  void _tapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }
}
