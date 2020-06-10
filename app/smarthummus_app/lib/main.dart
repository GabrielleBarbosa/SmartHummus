import 'package:flutter/material.dart';
import 'package:smarthummusapp/screens/home_screen.dart';

class SmartHummusApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(255, 4, 125, 141), //a, r, g, b
          fontFamily: 'Raleway'
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

void main(){
  runApp(SmartHummusApp());
}