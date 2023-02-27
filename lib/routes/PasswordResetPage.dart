import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../App.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key, required this.theme});
  final Map theme;

  State<PasswordResetPage> createState() => PasswordResetPageState();
}

class PasswordResetPageState extends State<PasswordResetPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.theme["primaryColor"],
          elevation: 0,
          leading: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => App(theme: widget.theme))),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: widget.theme["accentColor"],
                    size: 38.0,
                  ))),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 200),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Reset Your Password",
                        style: TextStyle(
                            fontFamily: "ManropeBold", fontSize: 32.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            child: TextField(
                              controller: idController,
                              obscureText: false,
                              cursorColor: widget.theme["secondaryColor"],
                              decoration: InputDecoration(
                                  fillColor: widget.theme["primaryColor"],
                                  prefixIcon: Icon(Icons.email,
                                      size: 28.8,
                                      color: _invalidAttempts == 0
                                          ? widget.theme["accentColor"]
                                          : widget.theme["errorColor"]),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: _invalidAttempts == 0
                                              ? widget.theme["accentColor"]
                                              : widget.theme["errorColor"],
                                          width: 2.4)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: _invalidAttempts == 0
                                              ? widget.theme["accentColor"]
                                              : widget.theme["errorColor"],
                                          width: 2.0)),
                                  label: const Text("Email"),
                                  labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: widget.theme["subtextColor"],
                                      fontFamily: "ManropeBold",
                                      fontWeight: FontWeight.bold)),
                            )))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                        onPressed: () {
                          if (!_busy) {
                            setState(() {
                              _busy = true;
                            });
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: idController.text.trim())
                                .then((res) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            App(theme: widget.theme))))
                                .catchError((e) {
                              _invalidAttempts++;
                              setState(() {
                                _busy = false;
                              });
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: _busy
                                ? const Color.fromARGB(255, 202, 202, 202)
                                : widget.theme["accentColor"],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            side: BorderSide(
                                width: 2.0,
                                color: _busy
                                    ? const Color.fromARGB(255, 202, 202, 202)
                                    : widget.theme["accentColor"]),
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 16)),
                        child: Text(
                          "Send Password Reset Link",
                          style: TextStyle(
                              color: widget.theme["primaryColor"],
                              fontFamily: "ManropeBold",
                              fontSize: 20.0),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                        visible: _invalidAttempts > 0,
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text("User doesn't exist",
                                style: TextStyle(
                                    color: widget.theme["errorColor"],
                                    fontSize: 18.0,
                                    fontFamily: "ManropeBold"))))
                  ],
                )
              ],
            )));
  }
}
