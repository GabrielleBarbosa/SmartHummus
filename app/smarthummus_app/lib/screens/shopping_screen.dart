import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_card.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          color: Color.fromRGBO(148, 223, 0, 1),
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(SmartHummusIcons.shopping_cart, color: Colors.white.withOpacity(0.6)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("MEU CARRINHO", style: GoogleFonts.raleway(color: Colors.white),),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                      width: 40,
                      child: Text("0", textAlign: TextAlign.center, style: GoogleFonts.raleway(color: Colors.white),),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("LOJA", style: GoogleFonts.raleway(fontSize: 35, fontWeight: FontWeight.w700)),
                  Icon(SmartHummusIcons.leaf, color: Color.fromRGBO(136, 240, 0, 1.0),),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                  children: [

                    Text("Mais procurados", style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(105, 105, 105, 1))),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    GestureDetector(
                      child: Text("Ver mais", style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(105, 105, 105, 1), decoration: TextDecoration.underline)),
                    )
                  ]
                ),
              ),
              ProductCard(Product("", "", "", "", "", "", "")),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                    children: [

                      Text("Novidades", style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(105, 105, 105, 1))),
                      Flexible(fit: FlexFit.tight, child: SizedBox()),
                      GestureDetector(
                        child: Text("Ver mais", style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(105, 105, 105, 1), decoration: TextDecoration.underline)),
                      )
                    ]
                ),
              ),
              ProductCard(Product("", "", "", "", "", "", "")),
            ],
          ),
        )
      ],
    );
  }
}
