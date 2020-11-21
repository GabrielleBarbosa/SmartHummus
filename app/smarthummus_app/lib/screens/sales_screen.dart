import 'package:flutter/material.dart';
import 'package:smarthummusapp/screens/add_product_sales_screen.dart';
import 'package:smarthummusapp/screens/sales_info_screen.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

  PageController _pageController = PageController();

  void _goToAddProd(){
    _pageController.jumpToPage(1);
  }

  void _returnToHomeSeller(){
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics:new NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          SalesInfoScreen(_goToAddProd),
          AddProductSalesScreen(_returnToHomeSeller)
        ],
      ),
    );
  }
}
