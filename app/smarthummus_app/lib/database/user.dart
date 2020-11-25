import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String name, photo, password, details, uid;
  double stars;
  int sells, purchases;
  List<String> comments;
  bool hasComposter, isSeller;

  User(this.name, this.photo, this.details,
      this.uid, this.stars, this.sells,
      this.purchases, this.comments, this.hasComposter, this.isSeller);

  User.fromDocument(DocumentSnapshot snapshot) {
    name = snapshot.data['nome'];
    photo = snapshot.data['foto'];
    details = snapshot.data['detalhes'];
    uid = snapshot.data['uid'];
    stars = snapshot.data['estrelas'];
    sells = snapshot.data['vendas'];
    purchases = snapshot.data['compras'];
    comments = snapshot.data['comentarios'];
    hasComposter = snapshot.data['temComposteira'];
    isSeller = snapshot.data['isVendedor'] == null ? false : snapshot.data['isVendedor'];
  }

  /*Map<String, dynamic> toMap(){
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
  }*/
}