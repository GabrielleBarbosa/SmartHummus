import 'package:flutter/material.dart';
import 'package:smarthummusapp/screens/home_screen.dart';
import 'package:smarthummusapp/screens/sign_in_screen.dart';
import 'package:smarthummusapp/screens/sign_up_screen.dart';

class SmartHummusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141), //a, r, g, b
        fontFamily: 'Raleway',
        inputDecorationTheme: InputDecorationTheme(
            focusColor: Color.fromRGBO(136, 240, 0, 1.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(136, 240, 0, 1.0), width: 3.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(136, 240, 0, 1.0), width: 3.0),
            )
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

void main() {
  runApp(SmartHummusApp());
}
