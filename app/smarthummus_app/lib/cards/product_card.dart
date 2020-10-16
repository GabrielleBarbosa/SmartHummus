import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/product.dart';

class ProductCard extends StatefulWidget {

  Product product;

  ProductCard(this.product);

  @override
  _ProductCardState createState() => _ProductCardState(this.product);
}

class _ProductCardState extends State<ProductCard> {

  Product product;

  _ProductCardState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, spreadRadius: 0, blurRadius: 8),
          ],
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/4.png'),
                    fit: BoxFit.cover,
                    width: 80,),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Composteira SmartHummus"),
                        Text("De VrRms", style: GoogleFonts.raleway(fontSize: 12, color: Color.fromRGBO(55, 55, 55, 1.0))),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Text("R\$420,00", style: GoogleFonts.raleway(fontSize: 20, color: Color.fromRGBO(136, 240, 0, 1.0)))
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        )
    );
  }
}
