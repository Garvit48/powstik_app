import 'package:flutter/material.dart';

class ThemeDropdown extends StatefulWidget {
  const ThemeDropdown(
      {super.key,
      required this.items,
      required this.theme,
      required this.hint,
      this.quantity});
  final Map theme;
  final List<String> items;
  final String hint;
  final String? quantity;
  State<ThemeDropdown> createState() => _ThemeDropdownState();
}

class _ThemeDropdownState extends State<ThemeDropdown> {
  String? selectedValue = null;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        borderRadius: BorderRadius.circular(11),
        underline: Container(height: 3.0, color: widget.theme["accentColor"]),
        dropdownColor: widget.theme["primaryColor"],
        onChanged: (String? value) => setState(() => selectedValue = value!),
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
        value: widget.quantity,
        items: widget.items
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
            .toList());
  }
}
