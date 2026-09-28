import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  }) : _auth = auth,
       _firestore = firestore,
       _googleSignIn = googleSignIn;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      print(userCredential.user?.email);
    } catch (e) {
      print(e);
    }
  }
}
