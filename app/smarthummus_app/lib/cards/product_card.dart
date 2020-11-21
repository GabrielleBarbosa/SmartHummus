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
        margin: EdgeInsets.only(top: 10, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      product.image != "" ? Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,) :
                      Image(
                        image: AssetImage('assets/images/4.png'),
                        fit: BoxFit.cover,
                        width: 50,),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: GoogleFonts.raleway(fontSize: 12, color: Color.fromRGBO(55, 55, 55, 1.0), fontWeight: FontWeight.w700)),
                            Text("De " + product.seller, style: GoogleFonts.raleway(fontSize: 11, color: Color.fromRGBO(55, 55, 55, 1.0))),
                            SizedBox(height: 10,),
                            Text("R\$"+product.price.toString(), style: GoogleFonts.raleway(fontSize: 20, color: Color.fromRGBO(180, 240, 0, 1.0), fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                    ],

                  ),
                )
            )
        )
    );
  }
}
