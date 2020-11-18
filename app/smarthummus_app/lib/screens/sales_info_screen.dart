import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_card_sales.dart';
import 'package:smarthummusapp/database/product.dart';

class SalesInfoScreen extends StatefulWidget {
  @override
  _SalesInfoScreenState createState() => _SalesInfoScreenState();
}

class _SalesInfoScreenState extends State<SalesInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(top: 40, left: 25, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("VENDAS",
              style: GoogleFonts.raleway(
                  fontSize: 30,
                  color: Color.fromRGBO(180, 240, 0, 1.0),
                  fontWeight: FontWeight.w800)),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0,
                              blurRadius: 10),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Vendas esta semana",
                                      style: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("5",
                                      style: GoogleFonts.raleway(
                                          fontSize: 22,
                                          color: Color.fromRGBO(55, 55, 55, 0.5),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0,
                              blurRadius: 10),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                            color: Color.fromRGBO(180, 240, 0, 1.0),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Lucro",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("30%",
                                      style: GoogleFonts.raleway(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )),
                      ))
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 30),
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0,
                          blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Atividade",
                                  style: GoogleFonts.raleway(
                                      fontSize: 15,
                                      color: Color.fromRGBO(55, 55, 55, 0.5),
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 5,
                              ),
                              Text("GRÁFICO",
                                  style: GoogleFonts.raleway(
                                      fontSize: 22,
                                      color: Color.fromRGBO(55, 55, 55, 0.5),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        )),
                  )),
            ],
          ),

          Text("MEUS PRODUTOS À VENDA",
              style: GoogleFonts.raleway(
                  fontSize: 18,
                  color: Color.fromRGBO(55, 55, 55, 0.5),
                  fontWeight: FontWeight.w700)),

          ProductCardSales(Product("", "", "", "", 0, "", 0))

        ],
      ),
    ));
  }
}
