import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 1️⃣ Create user in Firebase Auth
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw ServerException('User creation failed!');
      }

      // 2️⃣ Save additional user info in Firestore
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'FirebaseAuth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw ServerException('Login failed!');
      }

      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'FirebaseAuth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
