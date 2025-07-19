import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Stream<User?> get userChanges => _auth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future<void> register(String email, String password) async {
    try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    rethrow;
  }
}
}
