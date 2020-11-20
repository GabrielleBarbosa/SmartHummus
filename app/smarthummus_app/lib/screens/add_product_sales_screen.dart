import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/database/database.dart';

class AddProductSalesScreen extends StatefulWidget {
  @override
  _AddProductSalesScreenState createState() => _AddProductSalesScreenState();
}

class _AddProductSalesScreenState extends State<AddProductSalesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    new RotationTransition(
                      turns: AlwaysStoppedAnimation(270 / 360),
                      child: Image(
                        image: AssetImage('assets/images/folhas.png'),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/folhas.png'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2,
                    )
                  ],
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 2.5,
                        )
                      ]),
                ))
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    buildRow("Produto", titleController),
                    buildRow(
                        "Quantidade disponível (estoque)", stockController),
                    buildRow("Descrição", descriptionController),
                    buildRow("Detalhes (medidas, material, etc..)",
                        detailsController),
                    buildRow("Preço", priceController),
                    Padding(
                      padding: EdgeInsets.only(top:20, bottom: 20),
                      child: ButtonTheme(
                        minWidth: 30,
                        height: 50,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Color.fromRGBO(124, 219, 0, 1.0),
                            child: Text("Adicionar produto\nà venda",
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center),
                            onPressed: () {}),
                      ),
                    )
                  ],
                )),
          ],
        ),
    );
  }

  Widget buildRow(String title, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: title,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
