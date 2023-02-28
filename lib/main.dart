import 'package:flutter/material.dart';
import 'App.dart';
import 'package:firebase_core/firebase_core.dart';

Map _lightTheme = {
  "primaryColor": Color.fromARGB(255, 255, 255, 255),
  "secondaryColor": Color.fromARGB(255, 20, 20, 20),
  "accentColor": Color.fromARGB(255, 22, 190, 72),
  "subtextColor": Color.fromARGB(255, 68, 68, 68),
  "errorColor": Color.fromARGB(255, 255, 0, 92)
};

Map currentTheme = _lightTheme;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  _fbApp.then((value) => runApp(PowstikApp()));
}

class PowstikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(theme: currentTheme),
    );
  }
}
