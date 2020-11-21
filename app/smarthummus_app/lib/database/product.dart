import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String id, image, description, seller, title, details, sellerUid;
  int stock;
  double price;

  Product(this.title, this.description, this.details, this.image, this.price, this.stock, {this.sellerUid, this.id, this.seller});

  Product.fromDocument(DocumentSnapshot snapshot) {
    image= snapshot.data['imagem'];
    description= snapshot.data['descricao'];
    seller= snapshot.data['vendedor'];
    title= snapshot.data['titulo'];
    stock= snapshot.data['estoque'];
    details = snapshot.data['detalhes'];
    price= snapshot.data['preco']+0.0;
    sellerUid= snapshot.data['uidVendedor'];
  }

  Map<String, dynamic> toMap(){
    return {
      'titulo':this.title,
      'descricao':this.description,
      'detalhes':this.details,
      'imagem':this.image,
      'preco':this.price,
      'vendedor':this.seller,
      'estoque': this.stock,
      'uidVendedor': this.sellerUid,
      'data': Timestamp.now()
    };
  }
}