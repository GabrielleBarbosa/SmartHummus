import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class ProductScreen extends StatefulWidget {

  Product _product;
  Function(Product, int) _addToCart;

  ProductScreen(this._product, this._addToCart);

  @override
  _ProductScreenState createState() => _ProductScreenState(this._product);
}

class _ProductScreenState extends State<ProductScreen> {
  int quantidade = 1, estoque = 10;

  Product _product;

  _ProductScreenState(this._product);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estoque = _product.stock;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
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
                      child: Image.network(
                          _product.image,
                          fit: BoxFit.cover,
                          width: 140,
                      height:140),
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
                Text(_product.title.toUpperCase(),
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
                              _product.description,
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
                                  _product.details.replaceAll('\\n', '\n'),
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
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            ButtonTheme(
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                onPressed: quantidade == 1
                                    ? null
                                    : () {
                                        setState(() {
                                          quantidade--;
                                        });
                                      },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(quantidade.toString()),
                            ),
                            ButtonTheme(
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                onPressed: quantidade == estoque
                                    ? null
                                    : () {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("Preço"),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 14),
                          child: Text("R\$"+_product.price.toString(),
                              style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  color: Color.fromRGBO(148, 223, 0, 1),
                                  fontWeight: FontWeight.w500)),
                        ),
                        RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                color: Color.fromRGBO(148, 223, 0, 1),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(SmartHummusIcons.shopping_cart, color: Colors.white,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Adicionar", style: GoogleFonts.raleway(color: Colors.white),)
                                    ],
                                  ),
                                ),
                        onPressed: estoque == 0 ? null : (){widget._addToCart(widget._product, quantidade);},)
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
