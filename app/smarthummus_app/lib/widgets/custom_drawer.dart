import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/sign_in_screen.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0, top: 15.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 80.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Meu perfil",
                        style: GoogleFonts.raleway(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(55, 55, 55, 0.7)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Color.fromRGBO(136, 240, 0, 1.0), thickness: 1),
              DrawerTile(SmartHummusIcons.name, "Perfil", _pageController, 0),
              DrawerTile(Icons.settings, "Alterar dados", _pageController, 1),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        size: 32.0,
                      ),
                      SizedBox(width: 32.0),
                      Text(
                        "Sair",
                        style: TextStyle(fontSize: 16.6, color: Colors.black),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  bool logOut = await Database.signOut();
                  if (logOut) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
