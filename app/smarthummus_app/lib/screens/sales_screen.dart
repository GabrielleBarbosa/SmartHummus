import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/user.dart';
import 'package:smarthummusapp/screens/add_product_sales_screen.dart';
import 'package:smarthummusapp/screens/sales_info_screen.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  PageController _pageController = PageController();
  Future<User> _user;

  void _goToAddProd() {
    _pageController.jumpToPage(1);
  }

  void _returnToHomeSeller() {
    _pageController.jumpToPage(0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = Database.getPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData) return screen(snapshot.data);
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget screen(User user) {
    return user.isSeller
        ? Scaffold(
            body: PageView(
              physics: new NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                SalesInfoScreen(_goToAddProd),
                AddProductSalesScreen(_returnToHomeSeller)
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage("assets/images/not-seller.png"),
                  fit: BoxFit.cover,
                  width: 150),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Você ainda não é um vendedor SmartHummus? O que está esperando?",
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
                padding: EdgeInsets.only(top: 5, bottom: 5),
                color: Color.fromRGBO(124, 219, 0, 1.0),
                child: Container(
                    width: 130,
                    child: Text("Tornar-se um\nvendedor!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),),
                onPressed: () {
                  setState(() {
                    user.isSeller = true;
                  });
                },
              ),
            ],
          );
  }
}
