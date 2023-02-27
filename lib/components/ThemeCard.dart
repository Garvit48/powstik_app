import 'package:flutter/material.dart';

class ThemeCard extends StatefulWidget {
  const ThemeCard(
      {super.key,
      required this.cardInfo,
      required this.theme,
      required this.method});
  final Map cardInfo;
  final Map theme;
  final Function method;
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  bool _selected = false;
  Widget build(BuildContext context) {
    return Container(
        width: 180,
        height: 250,
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: widget.theme["accentColor"]),
            borderRadius: BorderRadius.circular(11)),
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Image(
                image: AssetImage(widget.cardInfo["image"]),
                width: 150,
                height: 150)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(widget.cardInfo["title"],
                style: TextStyle(
                    fontFamily: "ManropeBold",
                    fontSize: 22,
                    color: widget.theme["secondaryColor"]))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: TextButton(
                    onPressed: () {
                      widget.method();
                      setState(() => _selected = !_selected);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: _selected
                            ? widget.theme["subtextColor"]
                            : const Color.fromARGB(255, 255, 88, 0)),
                    child: Text(
                      _selected ? "Added to cart" : "Add to cart",
                      style: TextStyle(
                          fontFamily: "ManropeBold",
                          fontSize: 16,
                          color: widget.theme["secondaryColor"]),
                    )))
          ]),
        ]));
  }
}
