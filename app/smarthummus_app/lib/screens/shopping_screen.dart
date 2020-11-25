import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/cart_screen.dart';
import 'package:smarthummusapp/screens/home_shopping.dart';
import 'package:smarthummusapp/screens/product_screen.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> with AutomaticKeepAliveClientMixin<ShoppingScreen>{

  @override
  bool get wantKeepAlive => true;

  PageController _pageController = PageController();
  Product _product;
  List<Map<String, dynamic>> _cart = List<Map<String, dynamic>>();
  int _qtItems = 0;
  bool _isOnShopping = true;

  void _viewProduct(Product) {
    setState(() {
      _product = Product;
      _isOnShopping = false;
    });

    _pageController.jumpToPage(1);
  }

  void _addToCart(product, quantity) {

    bool repetido = false;
    for(int i=0; i<_cart.length; i++)
      if(_cart[i]['product'].id == product.id) {
        setState(() {
          _cart[i]['quantity'] += quantity;
        });
        repetido = true;
        break;
      }

    setState(() {
      if(!repetido) _cart.add({'product': product, 'quantity': quantity});
      _qtItems += quantity;
      _isOnShopping = false;
    });
    _pageController.jumpToPage(2);
  }

  void _removeFromCart(index, quantity) {
    setState(() {
      _cart.removeAt(index);
      _qtItems -= quantity;
      _isOnShopping = false;
    });

    _pageController.jumpToPage(2);
  }

  void _returnShopping() {
    setState(() {
      _isOnShopping = true;
    });

    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: _isOnShopping
              ? null
              : IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => _returnShopping(),
                ),
          title: GestureDetector(
            onTap: () {
              setState(() {
                _isOnShopping = false;
              });
              _pageController.jumpToPage(2);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(SmartHummusIcons.shopping_cart,
                    color: Colors.white.withOpacity(0.6)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "MEU CARRINHO",
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                      width: 40,
                      child: Text(
                        _qtItems.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeShopping(_viewProduct),
          ProductScreen(_product, _addToCart),
          CartScreen(_cart, _viewProduct, _removeFromCart, _returnShopping)
        ],
      ),
    );
  }
}
