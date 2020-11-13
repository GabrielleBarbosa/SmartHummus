import 'package:cloud_firestore/cloud_firestore.dart';

class Instruction {
  String title, content;
  bool isExpanded;

  Instruction({this.title, this.content, this.isExpanded});

  factory Instruction.fromJson(Map<String,dynamic> json) {
    return Instruction(
        title: json['titulo'],
        content: json['conteudo'],
        isExpanded: false
    );
  }

  Instruction.fromDocument(DocumentSnapshot snapshot){
    title= snapshot.data['titulo'];
    content= snapshot.data['conteudo'];
    isExpanded= false;
  }
}