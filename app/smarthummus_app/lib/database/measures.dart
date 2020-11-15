import 'package:cloud_firestore/cloud_firestore.dart';

class Measures {

  num tempA, tempB;
  num humA, humB;
  num gasMQ2, gasMQ135;
  bool isFull;
  String date;

  Measures({this.tempA, this.tempB, this.humA, this.humB, this.gasMQ2, this.gasMQ135, this.isFull, this.date});

  factory Measures.fromJson(Map<String,dynamic> json) {
    return Measures(
        tempA: json['temperatura1']+0.0,
        tempB: json['temperatura2']+0.0,
        humB: json['umidade1']+0.0,
        humA: json['umidade2']+0.0,
        gasMQ2: json['gasMQ2']+0.0,
        isFull: json['cheio'] == 0 ? false : true,
        gasMQ135: json['gasMQ135']+0.0,
        date: json['horario']
    );
  }

  Measures.fromDocument(DocumentSnapshot snapshot) {
        tempA= snapshot.data['temperatura1']+0.0;
        tempB= snapshot.data['temperatura2']+0.0;
        humB= snapshot.data['umidade1']+0.0;
        humA= snapshot.data['umidade2']+0.0;
        gasMQ2= snapshot.data['gasMQ2']+0.0;
        isFull= snapshot.data['cheio'] == 0 ? false : true;
        gasMQ135= snapshot.data['gasMQ135']+0.0;
        date= snapshot.data['horario'];
  }

}