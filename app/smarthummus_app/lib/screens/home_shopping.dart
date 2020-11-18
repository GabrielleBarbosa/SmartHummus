import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_card.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class HomeShopping extends StatefulWidget {

  final Function(Product) viewProduct;
  HomeShopping(this.viewProduct);

  @override
  _HomeShoppingState createState() => _HomeShoppingState();
}

class _HomeShoppingState extends State<HomeShopping> {

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
                    onTap: (){
                      widget.viewProduct(Product("","","","",6,"",6));
                    }
                    ,
                  )
                ]),
              ),
              GestureDetector(
                child: ProductCard(Product("", "", "", "", 0, "", 0)),
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
                  )
                ]),
              ),
              ProductCard(Product("", "", "", "", 0, "", 0)),
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
                  )
                ]),
              ),
              ProductCard(Product("", "", "", "", 0, "", 0)),
            ],
          ),
        ));
  }
}
