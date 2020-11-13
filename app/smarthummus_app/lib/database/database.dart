import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarthummusapp/news/measures.dart';

import 'instruction.dart';

class Database {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<FirebaseUser> getUser() async{
    return await FirebaseAuth.instance.currentUser();
  }

  static Future<String> getUserUid() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  static Future<FirebaseUser> signInGoogle() async{
    try{
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      final AuthResult authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      return authResult.user;
    }catch(e){
      return null;
    }
  }

  static Future<FirebaseUser> signUp(String email, String password) async{
      try{
        final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        return authResult.user;
      }catch(e){
        debugPrint(e.toString());
        return null;
      }
  }

  static Future<FirebaseUser> signInEmailPass(String email, String password) async{
    try{
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<bool> signOut() async{
    try {
      await FirebaseAuth.instance.signOut();
      _googleSignIn.signOut();
      return true;
    }
    catch(e){
      return false;
    }
  }

  static Future<List<Measures>> getMeasures() async{
    String uid = await getUser().then((value) => value.uid);
    QuerySnapshot allData = await Firestore.instance.collection("medidas").getDocuments();
    List<Measures> measures = List<Measures>();
    allData.documents.forEach((element) {
      if(element.data['uid'] == uid)
         measures.add(Measures.fromDocument(element));
    });
    return measures;
  }

  static Future<List<Instruction>> getInstructions() async{
    try{
      QuerySnapshot data = await Firestore.instance.collection("instrucoes").orderBy('number').getDocuments();
      List<Instruction> instructions = List<Instruction>();
      int i =0;
      data.documents.forEach((element) {
        instructions.add(Instruction.fromDocument(element));
        i++;
      });
      if(instructions.length == 0)
        return null;
      return instructions;
    }catch(e){
      return null;
    }
  }

  static Future<Measures> getMeasureNow() async {
    try{
      String uid = await getUserUid();
      var data = await Firestore.instance.collection('medidaAtual').document(uid).get();

      Measures m = Measures.fromDocument(data);
      if(m == null)
        return Measures() ;
      return m;
    }catch(e){
      throw Exception(e.toString());
    }
  }
}