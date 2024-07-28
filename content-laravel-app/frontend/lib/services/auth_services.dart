import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/globals.dart';
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '882483514486-k6nmfd18d0e433219i9o7mnr2rhkl5ne.apps.googleusercontent.com',
  );
  static const String webUrl = 'https://backend.pakar.diawan.id';

  Future<User?> signInWithGoogle() async {
    try { 
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getCsrfToken() async {
    final res = await http.get(Uri.parse('$webUrl/get-csrf'));

    if (res.statusCode == 200) {
      final resBody = jsonDecode(res.body);
      return {
        'csrf': resBody['csrf'],
        'error': null,
      };
    } else {
      final resBody = jsonDecode(res.body);
      return {
        'csrf': null,
        'error': resBody['message'],
      };
    }
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 160, 0, 0),
      ),
    );
  }
}