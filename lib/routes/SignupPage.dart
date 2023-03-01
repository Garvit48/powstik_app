import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AuthPage.dart';
import '../App.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.theme});
  final Map theme;

  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int _invalidAttempts = 0;
  bool _busy = false;
  bool validateEmail(String email) {
    if (email.contains("@") &&
        email.contains(".") &&
        email.indexOf("@") < email.indexOf(".") &&
        email.indexOf(".") != email.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.theme["accentColor"],
        body: Container(
          margin: const EdgeInsets.only(top: 140),
          child: Column(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Image(
                      image: AssetImage("assets/logo.png"),
                      width: 300,
                      height: 120)
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: TextField(
                          controller: idController,
                          obscureText: false,
                          cursorColor: widget.theme["secondaryColor"],
                          decoration: InputDecoration(
                              fillColor: widget.theme["primaryColor"],
                              prefixIcon: Icon(Icons.email,
                                  size: 28.8,
                                  color: _invalidAttempts == 0
                                      ? widget.theme["secondaryColor"]
                                      : widget.theme["errorColor"]),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: _invalidAttempts == 0
                                          ? widget.theme["secondaryColor"]
                                          : widget.theme["errorColor"],
                                      width: 2.4)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: _invalidAttempts == 0
                                          ? widget.theme["secondaryColor"]
                                          : widget.theme["errorColor"],
                                      width: 2.0)),
                              label: const Text(
                                  "Institute Email / Registration Number"),
                              labelStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: widget.theme["secondaryColor"],
                                  fontFamily: "ManropeBold",
                                  fontWeight: FontWeight.bold)),
                        )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(40, 15, 40, 4),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: widget.theme["secondaryColor"],
                          decoration: InputDecoration(
                              fillColor: widget.theme["primaryColor"],
                              prefixIcon: Icon(Icons.password,
                                  size: 28.8,
                                  color: _invalidAttempts == 0
                                      ? widget.theme["secondaryColor"]
                                      : widget.theme["errorColor"]),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: _invalidAttempts == 0
                                          ? widget.theme["secondaryColor"]
                                          : widget.theme["errorColor"],
                                      width: 2.4)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: _invalidAttempts == 0
                                          ? widget.theme["secondaryColor"]
                                          : widget.theme["errorColor"],
                                      width: 2.0)),
                              label: const Text("Password"),
                              labelStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: widget.theme["secondaryColor"],
                                  fontFamily: "ManropeBold",
                                  fontWeight: FontWeight.bold)),
                        )))
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AuthPage(theme: widget.theme)));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: widget.theme["secondaryColor"],
                            fontFamily: "ManropeBold",
                            decoration: TextDecoration.underline,
                            fontSize: 16.0),
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: OutlinedButton(
                        onPressed: _busy
                            ? null
                            : () {
                                if (!_busy) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: idController.text.trim(),
                                          password:
                                              passwordController.text.trim())
                                      .then((res) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                App(theme: widget.theme)));
                                  }).catchError((e) {
                                    _invalidAttempts++;
                                    print(e);
                                    setState(() => _busy = false);
                                  });
                                  setState(() => _busy = false);
                                }
                                setState(() {
                                  _busy = true;
                                });
                              },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: _busy
                                ? const Color.fromARGB(255, 202, 202, 202)
                                : widget.theme["secondaryColor"],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            side: BorderSide(
                                width: 2.0,
                                color: _busy
                                    ? const Color.fromARGB(255, 202, 202, 202)
                                    : widget.theme["accentColor"]),
                            padding:
                                const EdgeInsets.fromLTRB(120, 16, 120, 16)),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: widget.theme["primaryColor"],
                              fontFamily: "ManropeBold",
                              fontSize: 20.0),
                        )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: _invalidAttempts > 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text("Invalid Credentials or Network Error",
                          style: TextStyle(
                              fontFamily: "ManropeBold",
                              fontSize: 18.0,
                              color: widget.theme["errorColor"])),
                    ))
              ],
            )
          ]),
        ));
  }
}
