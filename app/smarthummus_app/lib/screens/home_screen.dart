import 'package:flutter/material.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/feed_screen.dart';
import 'package:smarthummusapp/screens/perfil_screen.dart';

import 'composter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<Widget> _pages = [FeedScreen(), Container(color: Colors.blue), ComposterScreen(), Container(color: Colors.purple), PerfilScreen()];
  final color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedindex],
        bottomNavigationBar: Container(
          color: color,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 8),
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
                      title: Text(""), icon: Icon(SmartHummusIcons.home)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(SmartHummusIcons.shopping_cart)),
                  BottomNavigationBarItem(
                      title: Text(""),
                      icon: Icon(SmartHummusIcons.composter, size: 60)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(SmartHummusIcons.pig)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(SmartHummusIcons.person)),
                ],
                backgroundColor: Colors.white,
                elevation: 1200,
                type: BottomNavigationBarType.fixed,
                iconSize: 35,
                showSelectedLabels: false,
                unselectedItemColor: Color.fromRGBO(195, 214, 220, 100.0),
                selectedItemColor: Color.fromRGBO(30, 67, 255, 100.0),
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
    });
  }
}
