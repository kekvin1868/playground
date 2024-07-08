import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          Future.microtask(() =>
          Navigator.of(context).pushReplacementNamed('/home'));
          return Container();
        } else {
          Future.microtask(() =>
          Navigator.of(context).pushReplacementNamed('/login'));
          return Container();
        }
      }
    );
  }
}