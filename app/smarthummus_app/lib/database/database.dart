import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Database {
  static FirebaseUser user;
  static String idToken;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<FirebaseUser> getUser() async{
    if(user != null) return user;
    try{
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      idToken = googleSignInAuthentication.accessToken;
      final AuthResult authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      user = authResult.user;

      return user;
    }catch(e){
      user = null;
      return null;
    }
  }
}