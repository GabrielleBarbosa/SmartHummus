import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/cards/product_card.dart';
import 'package:smarthummusapp/database/product.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';
import 'package:smarthummusapp/screens/home_shopping.dart';
import 'package:smarthummusapp/screens/product_screen.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  PageController _pageController = PageController();
  Product _product;

  void viewProduct(Product){
    if(Product != null){
      setState(() {
        _product = Product;
      });

      _pageController.jumpToPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
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
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                  width: 40,
                  child: Text(
                    "0",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )
      ,
      body: PageView(
        physics:new NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeShopping(viewProduct),
          ProductScreen(_product),
        ],
      ),
    );
  }

}
