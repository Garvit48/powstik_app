import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import './HomePage.dart';
import '../components/ThemeCard.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key, required this.user, required this.theme});
  final String user;
  final Map theme;

  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  final _database = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  List _products = [];
  List _activeSelection = [];

  @override
  void initState() {
    super.initState();
    _setListners();
  }

  void _setListners() {
    _database
        .child("/paths/userCarts/${auth.currentUser!.uid}/cart/")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final List data = event.snapshot.value as List;
        final filteredData = data.where((elem) => elem != null);

        setState(() {
          if (_products.isEmpty) {
            _activeSelection = filteredData.toList();
          }
          _products = filteredData.toList();
        });
      }
    });
  }

  void _removeItem(String id) {
    setState(() => _products.removeWhere((element) => element["id"] == id));
    setState(
        () => _activeSelection.removeWhere((element) => element["id"] == id));
    _database
        .child("/paths/userCarts/${auth.currentUser!.uid}/cart/")
        .set(_activeSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 212,
        elevation: 0,
        backgroundColor: widget.theme["primaryColor"],
        flexibleSpace: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 44, 0, 0),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(theme: widget.theme))),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 38,
                          color: widget.theme["secondaryColor"],
                        ))),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 44, 0, 0),
                    child: Text(
                      "Shopping Cart",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "ManropeBold",
                          color: widget.theme["secondaryColor"]),
                    )),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 36),
                child: SizedBox(
                    width: 344,
                    child: TextField(
                        onChanged: (target) {
                          setState(() => _activeSelection = _products
                              .where((dynamic product) => product["title"]
                                  .toLowerCase()
                                  .contains(target.toLowerCase()))
                              .toList());
                        },
                        obscureText: false,
                        cursorColor: widget.theme["secondaryColor"],
                        decoration: InputDecoration(
                            fillColor: widget.theme["primaryColor"],
                            suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.filter_alt,
                                  color: widget.theme["secondaryColor"],
                                  size: 28.8,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: widget.theme["accentColor"],
                                  width: 2.4,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: widget.theme["accentColor"],
                                  width: 2.0,
                                )),
                            labelText: "Search",
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: widget.theme["subtextColor"],
                                fontFamily: "ManropeBold",
                                fontWeight: FontWeight.bold)))))
          ],
        ),
        actions: const <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Wrap(
                children: _activeSelection
                    .map<Widget>((dynamic product) => ThemeCard(
                        cardInfo: product,
                        hint: "Quantity",
                        buttonInfo: const {
                          "postColor": Color.fromARGB(255, 255, 0, 85),
                          "preColor": Color.fromARGB(255, 255, 0, 85),
                          "preText": "Remove from Cart",
                          "postText": "Remove from Cart"
                        },
                        theme: widget.theme,
                        method: () => _removeItem(product["id"])))
                    .toList())),
      ),
    );
  }
}
