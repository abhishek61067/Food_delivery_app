import 'package:flutter/material.dart';
import 'package:food_del/config/colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? labText;
  TextInputType? keyboardType;
  CustomTextField({this.controller, this.keyboardType, this.labText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
        // enabledBorder: const OutlineInputBorder(
        //   // width: 0.0 produces a thin "hairline" border
        //   borderSide: const BorderSide(color: Colors.amber, width: 1.0),
        // ),
        // focusedBorder: const OutlineInputBorder(
        //   // width: 0.0 produces a thin "hairline" border
        //   borderSide: const BorderSide(color: Colors.amber),
        // ),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 181, 163, 3),
        ),
      ),
      cursorColor: primaryColor,
      // InputDecoration
    ); // TextField
  }
}
