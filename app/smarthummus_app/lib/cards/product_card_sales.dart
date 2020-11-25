import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class ProductCardSales extends StatefulWidget {

  Product product;
  Function(Product p) deleteProduct;

  ProductCardSales(this.product, this.deleteProduct);

  @override
  _ProductCardSalesState createState() => _ProductCardSalesState(this.product);
}

class _ProductCardSalesState extends State<ProductCardSales> {

  Product product;
  bool _deleting = false;
  bool _deleted = false;

  _ProductCardSalesState(this.product);

  @override
  Widget build(BuildContext context) {
    if(!_deleted) {
      return _deleting
          ? Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
          height: 40)
          : Container(
          margin: EdgeInsets.only(top: 20),
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
                          padding: EdgeInsets.only(
                              left: 10, top: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title, style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  color: Color.fromRGBO(
                                      55, 55, 55, 1.0),
                                  fontWeight: FontWeight.w700)),
                              Text("R\$" + product.price.toString(),
                                  style: GoogleFonts.raleway(
                                      fontSize: 20,
                                      color: Color.fromRGBO(180, 240, 0, 1.0),
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox(),),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                _deleting = true;
                              });
                              await widget.deleteProduct(product);
                              setState(() {
                                _deleted = true;
                              });
                            },
                            icon: Icon(Icons.restore_from_trash, size: 30,
                              color: Colors.red,)),
                        SizedBox(width: 5,),
                        Icon(Icons.edit, size: 30, color: Colors.blue,),
                      ],

                    ),
                  )
              )
          )
      );
    }
    else
      return Container();
  }
}
