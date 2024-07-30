import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopAuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateAuthState(true);
    } catch (e) {
      throw Exception('Failed SignUp: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _updateAuthState(false);
  }

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateAuthState(true);
    } catch (e) {
      throw Exception('Failed to Login $e');
    }
  }

  Future<void> _updateAuthState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
    notifyListeners(); // Notify listeners after updating state
  }

  Future<bool> get isAuthenticated async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }
}
