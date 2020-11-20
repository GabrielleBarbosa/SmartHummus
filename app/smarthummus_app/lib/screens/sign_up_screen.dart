import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void _signUp() async{
    String email = emailController.text, pass = passwordController.text, cpass = cpasswordController.text, name = nameController.text;
    if(email!= "" && pass!= "" && cpass!="" && name != "") {
      if(pass == cpass) {
        if(email.contains("@")) {
            FirebaseUser user = await Database.signUp(email, pass, name);
            if(user != null) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  buildRow(SmartHummusIcons.name, "Nome", nameController, 17.0,
                      false),
                  buildRow(SmartHummusIcons.mail, "E-mail", emailController,
                      17.0, false),
                  buildRow(
                      Icons.vpn_key, "Senha", passwordController, 23.0, true),
                  buildRow(SmartHummusIcons.confirm_password, "Confirmar Senha",
                      cpasswordController, 18.0, true),
                  Stack(
                    children: [
                      Image(
                        image: AssetImage("assets/images/background2.png"),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 150.0,
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  color: Color.fromRGBO(124, 219, 0, 1.0),
                                  child: Container(
                                      width: 130,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("PROSSEGUIR",
                                              style: GoogleFonts.raleway(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Icon(SmartHummusIcons.right_arrow,
                                                color: Colors.white, size: 15.0)
                                          )
                                        ],
                                      )),
                                  onPressed: _signUp
                                  ,
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

  Widget buildRow(IconData icon, String title, TextEditingController controller,
      double s, bool isHidden) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 50.0,
              height: 50.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    color: Color.fromRGBO(124, 219, 0, 1.0),
                    child: Icon(icon, size: s, color: Colors.white),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 180,
                child: TextField(
                  controller: controller,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    labelText: title,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
