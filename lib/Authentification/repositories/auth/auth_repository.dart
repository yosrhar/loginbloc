import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginbloc/Authentification/repositories/auth/base_auth_repository.dart';
import 'package:loginbloc/user_model.dart'as model;

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseAuth _authe = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    //get user details
    User currentUser = _authe.currentUser!;
  print('Current User UID: ${currentUser.uid}');
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
  print('User data from Firestore: ${snap.data()}');
    return model.User.fromSnap(snap);
  }

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
