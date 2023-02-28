import 'package:flutter/material.dart';
import './routes/AuthPage.dart';
import './routes/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  App({super.key, required this.theme});
  final Map theme;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage(theme: theme);
          } else {
            return AuthPage(theme: theme);
          }
        });
  }
}
