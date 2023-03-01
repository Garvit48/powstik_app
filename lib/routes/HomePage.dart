import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/ThemeCard.dart';
import 'UserCart.dart';

final List<Map> _products = [
  {
    "id": "1",
    "title": "Sudo Keema Samosa (250gm/Pack)",
    "price": "330.00",
    "quantity": "1",
    "image": "assets/p1.jpg"
  },
  {
    "id": "2",
    "title": "Sudo Plant Based Burger Patty (300gm)",
    "price": "330.00",
    "quantity": "1",
    "image": "assets/p2.jpg"
  },
  {
    "id": "3",
    "title":
        "Mindful Healthy Trail Mix with Fig & Raisin Dry Fruit, Tropical Fruits & Nuts, 200g",
    "price": "315.00",
    "quantity": "1",
    "image": "assets/p3.jpg"
  },
  {
    "id": "4",
    "title":
        "Mindful Healthy Trail Mix with Papaya & Pineapple Dry Fruit, Tropical Fruits & Nuts, 200g",
    "price": "315.00",
    "quantity": "1",
    "image": "assets/p4.jpg"
  },
  {
    "id": "5",
    "title": "Mindful Cashewm Oregano 300gm",
    "price": "550.00",
    "quantity": "1",
    "image": "assets/p5.jpg"
  },
  {
    "id": "6",
    "title": "5kg Low GI Combo",
    "price": "1099.00",
    "image": "assets/p6.jpg"
  },
  {
    "id": "7",
    "title": "Sudo Chicken Popcorn",
    "price": "330.00",
    "quantity": "1",
    "image": "assets/p7.jpg"
  },
  {
    "id": "8",
    "title": "Sudo mVegetarian Galouti Kebab (250gm)",
    "price": "330.00",
    "quantity": "1",
    "image": "assets/p8.jpg"
  },
  {
    "id": "9",
    "title": "Sudo-Plant Based Chicken Miracle Momos (230gm)",
    "price": "330.00",
    "quantity": "1",
    "image": "assets/p9.jpg"
  },
  {
    "id": "10",
    "title": "Sudo-Vegan Burger Patty and Popcorn (250gm/Pack)",
    "price": "630.00",
    "quantity": "1",
    "image": "assets/p10.jpg"
  },
];

final auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.theme});
  final Map theme;
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _database = FirebaseDatabase.instance.ref();
  List<Map> _activeSelection = _products;

  @override
  Widget build(BuildContext context) {
    final cartRef =
        _database.child("/paths/userCarts/${auth.currentUser!.uid}/cart/");
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
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: Icon(
                          Icons.logout,
                          size: 38,
                          color: widget.theme["secondaryColor"],
                        ))),
                Padding(
                    padding: EdgeInsets.fromLTRB(58, 44, 0, 0),
                    child: Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "ManropeBold",
                          color: widget.theme["secondaryColor"]),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(44, 44, 0, 0),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserCart(theme: widget.theme))),
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 40,
                          color: widget.theme["secondaryColor"],
                        )))
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
                        hint: "Quantity",
                        cardInfo: product,
                        buttonInfo: {
                          "preColor": const Color.fromARGB(255, 255, 88, 0),
                          "postColor": widget.theme["subtextColor"],
                          "preText": "Add to Cart",
                          "postText": "Added to Cart"
                        },
                        theme: widget.theme,
                        method: () {
                          cartRef
                              .update({product["id"]: product})
                              .then((value) => print("Success"))
                              .catchError((error) => print(error));
                        }))
                    .toList())),
      ),
    );
  }
}
//cartRef.set({"test": "test1"}).then((value) => print("Success")).catchError((error) => print(error))