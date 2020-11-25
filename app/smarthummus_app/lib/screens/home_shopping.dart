import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_card.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class HomeShopping extends StatefulWidget {

  final Function(Product) viewProduct;

  HomeShopping(this.viewProduct);

  @override
  _HomeShoppingState createState() => _HomeShoppingState();
}

class _HomeShoppingState extends State<HomeShopping> {

  bool _initialScreen = true;
  String _specificScreen = "Mais procurados";

  Future<List<Product>> _products;

  void _changeState(initial, specific) {
    setState(() {
      _initialScreen = initial;
      _specificScreen = specific;
    });
  }

  @override
  void initState() {
    super.initState();
    _products = Database.getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("LOJA",
                      style: GoogleFonts.raleway(
                          fontSize: 35, fontWeight: FontWeight.w700)),
                  Icon(
                    SmartHummusIcons.leaf,
                    color: Color.fromRGBO(180, 223, 0, 1),
                  ),
                ],
              ),
              _initialScreen ? _buildInit() : _buildSpecific()
            ],
          ),
        ));
  }

  Widget _buildInit() {
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(children: [
              Text("Mais procurados",
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(105, 105, 105, 1))),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              GestureDetector(
                  child: Text("Ver mais",
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(105, 105, 105, 1))),
                  onTap: () {
                    _changeState(false, "Mais procurados");
                  }
              )
            ]),
          ),
          FutureBuilder<List<Product>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  var index = snapshot.data.length < 3 ? snapshot.data.length : 2;
                  var display = snapshot.data.sublist(0, index);

                  return Column(
                      children: display.map<GestureDetector>((
                          Product product) {
                        return GestureDetector(
                            onTap: () {
                              widget.viewProduct(product);
                            },
                            child: ProductCard(product)
                        );
                      }).toList()
                  );
                }
                if (snapshot.hasError)
                  return Container(
                      alignment: Alignment.center,
                      child: Text(
                          "Ocorreu um erro ao carregar dados, verifique sua conexão")
                  );

                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                );
              }
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(children: [
              Text("Novidades",
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(105, 105, 105, 1))),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              GestureDetector(
                  child: Text("Ver mais",
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(105, 105, 105, 1))),
                  onTap: () {
                    _changeState(false, "Ver mais");
                  }
              )
            ]),
          ),
          ProductCard(Product(
              "Composteira",
              "",
              "",
              "",
              420.00,
              0,
          seller: "VrRms",)),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(children: [
              Text("Lançamentos",
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(105, 105, 105, 1))),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              GestureDetector(
                  child: Text("Ver mais",
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(105, 105, 105, 1))),
                  onTap: () {
                    _changeState(false, "Lançamentos");
                  }
              )
            ]),
          ),
          ProductCard(Product(
            "Composteira",
            "",
            "",
            "",
            420.00,
            0,
            seller: "VrRms",)),
          ProductCard(Product(
            "Composteira",
            "",
            "",
            "",
            420.00,
            0,
            seller: "VrRms",)),
        ]
    );
  }

  Widget _buildSpecific() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Text(_specificScreen,
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(105, 105, 105, 1))),),
          FutureBuilder<List<Product>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      children: snapshot.data.map<GestureDetector>((
                          Product product) {
                        return GestureDetector(
                            onTap: () {
                              widget.viewProduct(product);
                            },
                            child: ProductCard(product)
                        );
                      }).toList()
                  );
                }
                if (snapshot.hasError)
                  return Container(
                      alignment: Alignment.center,
                      child: Text(
                          "Ocorreu um erro ao carregar dados, verifique sua conexão")
                  );

                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                );
              }
          )
        ]
    );
  }
}
