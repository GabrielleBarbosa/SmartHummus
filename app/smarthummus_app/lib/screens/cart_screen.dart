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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
        itemCount: widget._cart.length + 1,
        itemBuilder: (context, index) {
          if (index == widget._cart.length) {
            double total = 0;
            for (var item in widget._cart)
              total += item['quantity'] * item['product'].price;
            return total != 0 ? _buildWithItems(total) : _buildWithoutItems();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
                  child: Text("Continuar Comprando"),
                  onPressed: () {
                    widget._returnShopping();
                  },
                )))
      ],
    );
  }

  Widget _buildWithoutItems() {
    return Column(
      children: [
        Text("Ops! Parece que não há nada no seu carrinho =("),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text("Retornar à área\nde compras"),
          onPressed: () {
            widget._returnShopping();
          },
        )
      ],
    );
  }
}
