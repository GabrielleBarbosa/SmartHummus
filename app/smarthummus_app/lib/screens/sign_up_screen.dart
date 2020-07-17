import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 3,
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
                        Icons.email,
                        size: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
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
                  borderSide: BorderSide(
                      color: Color.fromRGBO(143, 255, 0, 1.0), width: 2.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "ENTRAR",
                      style: GoogleFonts.raleway(
                          color: Color.fromRGBO(143, 255, 0, 1.0),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  onPressed: () {},
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
                          Icon(Icons.g_translate),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Google"),
                          )
                        ]),
                  ),
                  onPressed: () {},
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
                          Icon(Icons.g_translate),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Facebook"),
                          )
                        ]),
                  ),
                  onPressed: () {},
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Positioned.fill(
                        child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Não tem cadastro ainda? Cadastre-se!"),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: RaisedButton(
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
                                        Icon(Icons.g_translate),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text("Cadastrar"),
                                        )
                                      ]),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
