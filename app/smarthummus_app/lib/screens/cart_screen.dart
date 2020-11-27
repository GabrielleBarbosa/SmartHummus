import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_cart_card.dart';
import 'package:smarthummusapp/database/product.dart';

class CartScreen extends StatefulWidget {
  List<Map<String, dynamic>> _cart;
  Function(Product) _viewProduct;
  Function(int, int) _removeFromCart;
  Function() _returnShopping;

  CartScreen(this._cart, this._viewProduct, this._removeFromCart,
      this._returnShopping);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return widget._cart.length == 0
        ? _buildWithoutItems()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.builder(
              itemCount: widget._cart.length + 1,
              itemBuilder: (context, index) {
                if (index == widget._cart.length) {
                  double total = 0;
                  for (var item in widget._cart)
                    total += item['quantity'] * item['product'].price;
                  return _buildWithItems(total);
                }
                return Column(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ProductCartCard(
                            (widget._cart[index])['product'],
                            (widget._cart[index])['quantity'],
                            widget._removeFromCart,
                            index),
                      ),
                      onTap: () {
                        widget._viewProduct((widget._cart[index])['product']);
                      },
                    ),
                    Divider()
                  ],
                );
              },
            ),
          );
  }

  Widget _buildWithItems(total) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "Total: R\$" + total.toString(),
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
        ),
      ),
      RaisedButton(
        child: Text("Finalizar Compra"),
      ),
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Color.fromRGBO(148, 223, 0, 1),
                child: Text(
                  "Continuar Comprando",
                  style: GoogleFonts.raleway(color: Colors.white),
                ),
                /**/ onPressed: () {
                  widget._returnShopping();
                },
              )))
    ]);
  }

  Widget _buildWithoutItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
            image: AssetImage("assets/images/empty-cart.png"),
            fit: BoxFit.cover,
            width: 150),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            "Ops! Parece que não há nada no seu carrinho =(",
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Color.fromRGBO(124, 219, 0, 1.0),
          child: Container(
            width: 130,
            child: Text("Retornar à área\nde compras",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
          onPressed: () {
            widget._returnShopping();
          },
        ),
      ],
    );
  }
}
