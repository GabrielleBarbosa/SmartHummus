import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class ProductCartCard extends StatefulWidget {
  Product product;
  int quantity;
  Function(int, int) removeFromCart;
  int index;

  ProductCartCard(this.product, this.quantity, this.removeFromCart, this.index);

  @override
  _ProductCartCardState createState() =>
      _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(widget.quantity.toString(),
              style: GoogleFonts.raleway(
                  fontSize: 28,
                  color: Color.fromRGBO(55, 55, 55, 1.0),
                  fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.title,
                  style: GoogleFonts.raleway(
                      fontSize: 12,
                      color: Color.fromRGBO(55, 55, 55, 1.0),
                      fontWeight: FontWeight.w700)),
              Text("R\$" + widget.product.price.toString(),
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: Color.fromRGBO(180, 240, 0, 1.0),
                      fontWeight: FontWeight.w700))
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(),
        ),
        GestureDetector(
          child: Icon(
            Icons.restore_from_trash,
            size: 30,
            color: Colors.red,
          ),
          onTap: () {
            widget.removeFromCart(widget.index, widget.quantity);
          },
        )
      ],
    );
  }
}
