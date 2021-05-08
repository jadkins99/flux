// modified from the covid tracker assignment
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/utilities/styles.dart';

class ColoredTextField extends StatelessWidget {
  final String label;
  final Color color;
  final TextEditingController controller;

  const ColoredTextField({
    @required this.label,
    @required this.color,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color)),
        ),
      )
    ]);
  }
}