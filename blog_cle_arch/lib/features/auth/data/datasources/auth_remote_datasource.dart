import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw ServerException('User creation failed!');
      }

      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return UserModel(id: user.uid, email: email, name: name);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'FirebaseAuth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
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

      final doc = await firestore.collection('users').doc(user.uid).get();
      final data = doc.data();

      if (data == null) {
        throw ServerException('User data not found');
      }

      return UserModel(id: user.uid, email: data['email'], name: data['name']);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'FirebaseAuth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
