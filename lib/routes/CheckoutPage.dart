import 'package:flutter/material.dart';
import 'UserCart.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.theme});
  final Map theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserCart(theme: theme))),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: theme["accentColor"],
                  size: 38.0,
                ))),
      ),
    );
  }
}
