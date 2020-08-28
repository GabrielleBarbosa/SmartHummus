import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/feed_screen.dart';
import 'package:smarthummusapp/screens/home_screen.dart';
import 'package:smarthummusapp/screens/humidity_screen.dart';
import 'package:smarthummusapp/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void logInGoogle() async{

    FirebaseUser user = await Database.getUser();
    if(user != null)
      Navigator.push(context, MaterialPageRoute (builder: (context) => HomeScreen()));
      //debugPrint(Database.idToken);
    else
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Não foi possível fazer o login")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    new RotationTransition(
                      turns: AlwaysStoppedAnimation(270 / 360),
                      child: Image(
                        image: AssetImage('assets/images/folhas.png'),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/folhas.png'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2,
                    )
                  ],
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 2.5,
                        )
                      ]),
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        SmartHummusIcons.mail,
                        size: 17,
                        color: Color.fromRGBO(198, 226, 235, 1.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: SizedBox(
                          width: 220,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.vpn_key,
                        size: 22,
                        color: Color.fromRGBO(198, 226, 235, 1.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 220,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                      child: GestureDetector(
                        child: Text(
                          "Esqueci minha senha",
                          style: GoogleFonts.raleway(color: Colors.grey),
                        ),
                        onTap: () {},
                      )),
                  OutlineButton(
                    splashColor: Color.fromRGBO(136, 240, 0, 1.0),
                    highlightColor: Colors.transparent,
                    highlightedBorderColor: Color.fromRGBO(136, 240, 0, 1.0),
                    textColor: Color.fromRGBO(136, 240, 0, 1.0),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(136, 240, 0, 1.0), width: 2.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "ENTRAR",
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("ou"),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.red,
                    child: Container(
                      width: 100,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(SmartHummusIcons.google,
                                size: 20.0, color: Colors.white),
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text("Google",
                                  style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            )
                          ]),
                    ),
                    onPressed: logInGoogle,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.blue,
                    child: Container(
                      width: 100,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(SmartHummusIcons.facebook,
                                size: 25.0, color: Colors.white),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("Facebook",
                                  style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            )
                          ]),
                    ),
                    onPressed: () {},
                  ),
                  Stack(
                    children: [
                      Image(
                        image: AssetImage("assets/images/background2.png"),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Não tem cadastro ainda? Cadastre-se!",
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(0, 0, 0, 0.6))),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color.fromRGBO(124, 219, 0, 1.0),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text("CADASTRAR",
                                                style: GoogleFonts.raleway(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          )
                                        ]),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
