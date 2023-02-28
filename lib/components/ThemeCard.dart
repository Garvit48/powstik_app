import 'package:flutter/material.dart';
import 'ThemeDropdown.dart';

class ThemeCard extends StatefulWidget {
  const ThemeCard({
    super.key,
    required this.cardInfo,
    required this.theme,
    required this.buttonInfo,
    required this.method,
    required this.hint,
  });
  final Map cardInfo;
  final Map theme;
  final Map buttonInfo;
  final String hint;
  final Function() method;

  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  bool _selected = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180,
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: widget.theme["accentColor"]),
            borderRadius: BorderRadius.circular(11)),
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 12),
                child: Image(
                    image: AssetImage(widget.cardInfo["image"]),
                    width: 150,
                    height: 150))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Expanded(
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Text(widget.cardInfo["title"],
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "ManropeBold",
                            fontSize: 18,
                            color: widget.theme["secondaryColor"]))))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Expanded(
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Text("Rs. ${widget.cardInfo['price']}",
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "ManropeBold",
                            fontSize: 20,
                            color: widget.theme["subtextColor"]))))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            DropdownButton<String>(
                borderRadius: BorderRadius.circular(11),
                underline:
                    Container(height: 3.0, color: widget.theme["accentColor"]),
                dropdownColor: widget.theme["primaryColor"],
                onChanged: (String? value) =>
                    setState(() => widget.cardInfo["quantity"] = value!),
                icon: Icon(Icons.arrow_drop_down,
                    size: 28, color: widget.theme["accentColor"]),
                style: TextStyle(
                    fontFamily: "ManropeBold",
                    fontSize: 22,
                    color: widget.theme["secondaryColor"]),
                hint: Text(widget.hint,
                    style: TextStyle(
                        fontFamily: "ManropeBold",
                        fontSize: 20,
                        color: widget.theme["secondaryColor"])),
                value: widget.cardInfo["quantity"],
                items: ["1", "2", "3", "4"]
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList())
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Tooltip(
                    message: "Test",
                    triggerMode: TooltipTriggerMode.tap,
                    child: TextButton(
                        onPressed: () {
                          widget.method();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: _selected
                                ? widget.buttonInfo["postColor"]
                                : widget.buttonInfo["preColor"]),
                        child: Text(
                          _selected
                              ? widget.buttonInfo["postText"]
                              : widget.buttonInfo["preText"],
                          style: TextStyle(
                              fontFamily: "ManropeBold",
                              fontSize: 16,
                              color: widget.theme["secondaryColor"]),
                        ))))
          ]),
        ]));
  }
}
