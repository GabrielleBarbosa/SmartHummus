import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/product.dart';

class AddProductSalesScreen extends StatefulWidget {

  Function() returnToHomeSeller;

  AddProductSalesScreen(this.returnToHomeSeller);

  @override
  _AddProductSalesScreenState createState() => _AddProductSalesScreenState();
}

class _AddProductSalesScreenState extends State<AddProductSalesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  File _imgFile;
  ImagePicker _picker = ImagePicker();
  String _errorMessage = "";
  bool _isLoading = false;

  void _pickFile() async {

    try {
      final imgFile = await _picker.getImage(source: ImageSource.gallery);
      if (imgFile != null) {
        setState(() {
          _imgFile = File(imgFile.path);
        });
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void _saveNewProduct() async{

    if(_imgFile == null){
      setState(() {
        _errorMessage = "Escolha uma imagem para representar seu produto, por favor!";
      });
      return;
    }

    String title = titleController.text.trim(),
           description = descriptionController.text.trim(),
           details = detailsController.text.trim();

    if(title == "" || description == "" || details == ""){
      setState(() {
        _errorMessage = "Preencha todos os campos!";
      });
      return;
    }

    int stock;
    try{
      stock = int.parse(stockController.text.trim());
    }catch(e){
      setState(() {
        _errorMessage = "Digite um número inteiro para o estoque, por favor!";
      });
      return;
    }

    double price;
    try{
      price = double.parse(priceController.text.trim().replaceAll(',', '.'));
    }catch(e){
      setState(() {
        _errorMessage = "Digite um número para o preço, por favor! Não precisa colocar unidade de moeda como \"R\$\".";
      });
      return;
    }

    setState((){
      _isLoading = true;
    });

    try {
      await Database.saveNewProduct(
          Product(title, description, details, "", price, stock), _imgFile);
    }catch(e){
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      return;
    }

    titleController.text = ""; stockController.text = ""; detailsController.text = ""; descriptionController.text = ""; priceController.text = "";
    setState((){
      _imgFile = null;
      _errorMessage = "";
      _isLoading = false;
    });
    widget.returnToHomeSeller();
  }

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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _imgFile == null
                          ? IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: _pickFile
                      )
                          : GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.file(
                            _imgFile,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,),
                        ),
                        onTap: _pickFile,
                      ),
                ]),
              )),
              Positioned.fill(child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: IconButton(icon: Icon(Icons.arrow_back, size: 40), onPressed: (){widget.returnToHomeSeller();},),
                )
              ))
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  buildRow("Produto", titleController),
                  buildRow("Quantidade disponível (estoque)", stockController),
                  buildRow("Descrição", descriptionController),
                  buildRow(
                      "Detalhes (medidas, material, etc..)", detailsController),
                  buildRow("Preço", priceController),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
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
                          onPressed: _saveNewProduct),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    child: Text(_errorMessage, style: GoogleFonts.raleway(color: Colors.redAccent), textAlign: TextAlign.center)
                  ),
                  _isLoading ? Container(alignment: Alignment.center, child: CircularProgressIndicator()) : Container()
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
