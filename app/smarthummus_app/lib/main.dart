import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarthummusapp/screens/home_screen.dart';
import 'package:smarthummusapp/screens/introduction_screen.dart';
import 'package:smarthummusapp/screens/manage_perfil_screen.dart';
import 'package:smarthummusapp/screens/sign_in_screen.dart';
import 'package:smarthummusapp/screens/sign_up_screen.dart';
import 'package:smarthummusapp/widgets/custom_drawer.dart';

import 'database/database.dart';

class SmartHummusApp extends StatelessWidget {

  final String initialRoute;

  SmartHummusApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(136, 240, 0, 1.0), //a, r, g, b
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
      initialRoute: initialRoute,
      routes: {
        '/': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseUser user = await Database.getUser();
  final bool isLogged = user!=null;
  final SmartHummusApp myApp = SmartHummusApp(
    initialRoute: isLogged ? '/home' : '/'
  );
  runApp(myApp);
}
