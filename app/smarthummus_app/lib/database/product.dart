import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String id, image, description, seller, title, details;
  int stock;
  double price;

  Product(this.title, this.description, this.details, this.id, this.image, this.price, this.seller, this.stock);

  Product.fromDocument(DocumentSnapshot snapshot) {
    image= snapshot.data['imagem'];
    description= snapshot.data['descricao'];
    seller= snapshot.data['vendedor'];
    title= snapshot.data['titulo'];
    stock= snapshot.data['estoque'];
    details = snapshot.data['detalhes'];
    price= snapshot.data['preco']+0.0;
  }
}