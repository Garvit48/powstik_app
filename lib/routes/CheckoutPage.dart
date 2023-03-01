import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'UserCart.dart';
import '../App.dart';

final _database = FirebaseDatabase.instance.ref();
final _auth = FirebaseAuth.instance;

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key, required this.theme, required this.items});
  final Map theme;
  final List items;

  final cartRef =
      _database.child("/paths/userCarts/${_auth.currentUser!.uid}/cart/");

  double arrSum(List arr) {
    double sum = 0;
    arr.forEach((elem) {
      sum += double.parse(elem["quantity"]);
    });
    return sum;
  }

  Widget _itemBuilder(Map itemInfo) {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        child: ListTile(
          leading: Image(
              image: AssetImage(itemInfo["image"]), width: 120, height: 120),
          title: Column(children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Text(
                itemInfo["title"],
                softWrap: true,
                style: TextStyle(
                    fontFamily: "ManropeBold",
                    fontSize: 22,
                    color: theme["secondaryColor"]),
              ))
            ]),
            Row(children: <Widget>[
              Expanded(
                  child: Text(
                "Rs. ${itemInfo['price']}",
                style: TextStyle(
                    fontFamily: "ManropeBold",
                    fontSize: 16,
                    color: theme["subtextColor"]),
              ))
            ]),
            Row(children: <Widget>[
              Expanded(
                  child: Text("Quantity: ${itemInfo['quantity']}",
                      style: TextStyle(
                          fontFamily: "ManropeBold",
                          fontSize: 16,
                          color: theme["subtextColor"])))
            ])
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme["primaryColor"],
        toolbarHeight: 212,
        elevation: 0,
        flexibleSpace: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 44, 0, 0),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => UserCart(theme: theme))),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 38,
                          color: theme["secondaryColor"],
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(58, 44, 0, 0),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "ManropeBold",
                          color: theme["secondaryColor"]),
                    ))
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 36),
                child: SizedBox(
                  width: 344,
                  height: 56,
                  child: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            theme["accentColor"])),
                    onPressed: () {
                      cartRef.remove();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => App(theme: theme)));
                    },
                    child: Text("Checkout",
                        style: TextStyle(
                            fontFamily: "ManropeBold",
                            fontSize: 20,
                            color: theme["primaryColor"])),
                  ),
                ))
          ],
        ),
      ),
      body: ListView(
        children: items.map((item) => _itemBuilder(item)).toList(),
      ),
    );
  }
}
