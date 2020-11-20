import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarthummusapp/database/product.dart';

import 'instruction.dart';
import 'measures.dart';

class Database {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<FirebaseUser> getUser() async{
    return await FirebaseAuth.instance.currentUser();
  }

  static Future<String> getUserUid() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  static Future<String> getUsername() async{
    try{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.displayName;
    }catch(e){
      throw Exception(e.toString());
    }
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

      try{
        await hasComposter();
      }catch(e){
        setHasComposter(authResult.user.uid, false);
        setIsSeller(authResult.user.uid, false);
      }

      return authResult.user;
    }catch(e){
      return null;
    }
  }

  static Future<FirebaseUser> signUp(String email, String password, String name) async{
      try{
        final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await setHasComposter(authResult.user.uid, false);
        await setIsSeller(authResult.user.uid, false);

        UserUpdateInfo info = new UserUpdateInfo();
        info.displayName = name;

        var user = await getUser();
        await user.updateProfile(info);
        await user.reload();

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

  static Future<void> setHasComposter(uid, newValue) async{
    try{
      await Firestore.instance.collection('users').document(uid).setData({'temComposteira': newValue});
    }catch(e){
      throw Exception (e.toString());
    }
  }

  static Future<void> setIsSeller(uid, newValue) async{
    try{
      await Firestore.instance.collection('users').document(uid).setData({'isVendedor': newValue});
    }catch(e){
      throw Exception (e.toString());
    }
  }
  /*static Future<List<Measures>> getMeasures() async{
    String uid = await getUser().then((value) => value.uid);
    QuerySnapshot allData = await Firestore.instance.collection("medidas").getDocuments();
    List<Measures> measures = List<Measures>();
    allData.documents.forEach((element) {
      if(element.data['uid'] == uid)
         measures.add(Measures.fromDocument(element));
    });
    return measures;
  }*/

  static Future<bool> hasComposter() async{
    try {
      String uid = await getUserUid();
      DocumentSnapshot data = await Firestore.instance.collection('users').document(uid).get();

      return data.data['temComposteira'];

    }catch(e){
      throw Exception(e.toString());
    }
  }

  static Future<bool> isSeller() async{
    try {
      String uid = await getUserUid();
      DocumentSnapshot data = await Firestore.instance.collection('users').document(uid).get();

      return data.data['isVendedor'];

    }catch(e){
      throw Exception(e.toString());
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

  static Future<List<Product>> getProducts() async {
    try{
      QuerySnapshot data = await Firestore.instance.collection('produtos').getDocuments();

      List<Product> products = List<Product>();
      data.documents.forEach((element) {
        products.add(Product.fromDocument(element));
      });

      if(products.length == 0)
        return null;

      return products;
    }catch(e){
      throw Exception(e.toString());
    }
  }

  static Future<List<Instruction>> getInstructions() async{
    try{
      QuerySnapshot data = await Firestore.instance.collection("instrucoes").orderBy('number').getDocuments();
      List<Instruction> instructions = List<Instruction>();
      data.documents.forEach((element) {
        instructions.add(Instruction.fromDocument(element));
      });
      if(instructions.length == 0)
        return null;
      return instructions;
    }catch(e){
      return null;
    }
  }
}