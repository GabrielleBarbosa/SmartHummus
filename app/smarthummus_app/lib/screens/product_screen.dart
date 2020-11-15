import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantidade = 1, estoque = 10;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
            height: 100,
            color: Color.fromRGBO(148, 223, 0, 1),
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(SmartHummusIcons.shopping_cart,
                      color: Colors.white.withOpacity(0.6)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "MEU CARRINHO",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                        width: 40,
                        child: Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: 180,
            ),
            Container(
              color: Color.fromRGBO(169, 255, 0, 1.0),
              height: 100,
            ),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                          image: AssetImage("assets/images/perfil.png"),
                          fit: BoxFit.cover,
                          width: 140),
                    )))
          ],
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                    color: Color.fromRGBO(195, 214, 220, 100.0), thickness: 2),
                SizedBox(
                  height: 10,
                ),
                Text("Composteira SmartHummus".toUpperCase(),
                    style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(55, 55, 55, 0.7))),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Icon(SmartHummusIcons.star,
                        size: 20, color: Color.fromRGBO(169, 255, 0, 1.0)),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Expanded(
                          child: Text(
                              "Composteira doméstica automatizada integrada ao aplicativo do SmartHummus. Seja mais sustentável de forma simples e prática!",
                              style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Color.fromRGBO(55, 55, 55, 1.0))),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(SmartHummusIcons.pig,
                        size: 20, color: Color.fromRGBO(169, 255, 0, 1.0)),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Detalhes",
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(55, 55, 55, 0.9))),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Expanded(
                              child: Text(
                                  "- Capacidade: 15L \n- Dimensões: 43 cm x 37 cm x 45 cm \n- Não produz odor \n- Não acompanha minhocas  \n\n*Imagens meramente ilustrativas*",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color.fromRGBO(55, 55, 55, 1.0))),
                            ))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                    color: Color.fromRGBO(195, 214, 220, 100.0), thickness: 2),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Quantidade"),
                        Row(
                          children: <Widget>[
                            ButtonTheme(
                              padding: EdgeInsets.all(0),
                              minWidth: 25,
                              height: 25,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: Color.fromRGBO(169, 255, 0, 1.0),
                                child: Container(
                                  child: Text("-"),
                                ),

                                onPressed: quantidade == 1 ? null :  (){
                                  setState(() {
                                    quantidade--;
                                  });
                                },
                              ),
                            ),

                            Text(quantidade.toString()),

                            ButtonTheme(
                              padding: EdgeInsets.all(0),
                              minWidth: 25,
                              height: 25,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: Color.fromRGBO(169, 255, 0, 1.0),
                                child: Container(
                                  child: Text("+"),
                                ),

                                onPressed: quantidade == estoque ? null :  (){
                                  setState(() {
                                    quantidade++;
                                  });
                                },
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Column(
                      children: <Widget>[
                        Text("Preço"),
                      ],
                    )
                  ],
                )
              ],
            ))
      ],
    ));
  }
}
