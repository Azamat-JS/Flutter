import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _isInitialized = false;
  static const String _iosClientId =
      '144526956063-7kert8luq6bg7dd0bsufen5eveq992j2.apps.googleusercontent.com';

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      await _googleSignIn.initialize(clientId: _iosClientId);
    } else {
      await _googleSignIn.initialize();
    }
    _isInitialized = true;
  }

  Future<UserCredential?> signInWithGoogle() async {
    await _ensureInitialized();
    try {
      final GoogleSignInAccount gUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication gAuth = gUser.authentication;
      if (gAuth.idToken == null) {
        return null;
      }
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }
}
