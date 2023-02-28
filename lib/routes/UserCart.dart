import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import './HomePage.dart';
import '../components/ThemeCard.dart';

final List<Map<String, String>> _products = [
  {
    "title": "Sudo – Keema Samosa (250gm/Pack)",
    "price": "330.00",
    "image": "assets/p1.jpg"
  },
  {
    "title": "Sudo – Plant Based Burger Patty (300gm)",
    "price": "330.00",
    "image": "assets/p2.jpg"
  },
  {
    "title":
        "Mindful Healthy Trail Mix with Papaya & Pineapple – Dry Fruit, Tropical Fruits & Nuts, 200g",
    "price": "315.00",
    "image": "assets/p4.jpg"
  },
  {"title": "5kg Low GI Combo", "price": "1099.00", "image": "assets/p6.jpg"},
  {
    "title": "Sudo – Vegetarian Galouti Kebab (250gm)",
    "price": "330.00",
    "image": "assets/p8.jpg"
  },
  {
    "title": "Sudo-Vegan Burger Patty and Popcorn (250gm/Pack)",
    "price": "630",
    "image": "assets/p10.jpg"
  },
];

class UserCart extends StatefulWidget {
  const UserCart({super.key, required this.user, required this.theme});
  final String user;
  final Map theme;

  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  List<Map<String, String>> _activeSelection = _products;
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
                              .where((Map product) => product["title"]
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
                    .map<Widget>((Map product) => ThemeCard(
                        cardInfo: product,
                        buttonInfo: const {
                          "postColor": Color.fromARGB(255, 255, 0, 85),
                          "preColor": Color.fromARGB(255, 255, 0, 85),
                          "preText": "Remove from Cart",
                          "postText": "Remove from Cart"
                        },
                        theme: widget.theme,
                        method: () =>
                            setState(() => _activeSelection.remove(product))))
                    .toList())),
      ),
    );
  }
}
