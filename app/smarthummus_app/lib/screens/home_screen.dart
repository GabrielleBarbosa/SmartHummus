import 'package:flutter/material.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/feed_screen.dart';
import 'package:smarthummusapp/screens/manage_perfil_screen.dart';
import 'package:smarthummusapp/screens/sales_screen.dart';
import 'package:smarthummusapp/screens/shopping_screen.dart';

import 'composter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<Widget> _pages = [FeedScreen(), ShoppingScreen(), ComposterScreen(), SalesScreen(), ManagePerfilScreen()];
  PageController _pageController = PageController();
  final color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(SmartHummusIcons.composter, size: 40)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(SmartHummusIcons.pig)),
                  BottomNavigationBarItem(
                      title: Text(""), icon: Icon(SmartHummusIcons.person)),
                ],
                backgroundColor: Colors.white,
                elevation: 1200,
                type: BottomNavigationBarType.fixed,
                iconSize: 20,
                showSelectedLabels: false,
                unselectedItemColor: Color.fromRGBO(195, 214, 220, 100.0),
                selectedItemColor: Color.fromRGBO(30, 67, 255, 100.0),
                showUnselectedLabels: false,
                currentIndex: _selectedindex,
                onTap: _tapped,
              ),
            )
        )
    ), body: PageView(
      controller: _pageController,
      children: _pages,
      onPageChanged: (index){
        setState(() {
          _selectedindex = index;
        });
      },
    ),);
  }

  int _selectedindex = 0;
  void _tapped(index) {
    setState(() {
      _selectedindex = index;
    });
    _pageController.jumpToPage(index);
  }
}
