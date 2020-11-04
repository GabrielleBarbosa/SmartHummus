import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/screens/feed_screen.dart';
import 'package:smarthummusapp/screens/home_screen.dart';
import 'package:smarthummusapp/screens/perfil_screen.dart';
import 'package:smarthummusapp/screens/setting_screen.dart';
import 'package:smarthummusapp/screens/setting_screen.dart';
import 'package:smarthummusapp/screens/sign_in_screen.dart';
import 'package:smarthummusapp/screens/sign_up_screen.dart';
import 'package:smarthummusapp/widgets/custom_drawer.dart';

class ManagePerfilScreen extends StatefulWidget {
  @override
  _ManagePerfilScreenState createState() => _ManagePerfilScreenState();
}

class _ManagePerfilScreenState extends State<ManagePerfilScreen> {
    final _pageController = PageController();

    @override
    Widget build(BuildContext context) {
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.short_text, color: Colors.white, size: 50.0),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              elevation: 0,
              backgroundColor: Color.fromRGBO(121, 55, 180, 1.0),
            ),
            body: PerfilScreen(),
            drawer: CustomDrawer(_pageController),
          ),
          Scaffold(
              appBar: AppBar(
                title: Text("Produtos"),
                centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              body: SettingScreen()
          ),
        ],
      );
  }
}
