import 'package:cloud_firestore/cloud_firestore.dart';

class Measures {

  num tempA, tempB;
  num humA, humB;
  num gasMQ2, gasMQ135;
  bool isFull;

  Measures.fromDocument(DocumentSnapshot snapshot){
    tempA = snapshot.data['temperatura1']+0.0;
    tempB = snapshot.data['temperatura2']+0.0;
    humA = snapshot.data['umidade1']+0.0;
    humB = snapshot.data['umidade2']+0.0;
    gasMQ2 = snapshot.data['gasMQ2']+0.0;
    gasMQ135 = snapshot.data['gasMQ135']+0.0;
    isFull = snapshot.data['cheio'];
  }

}