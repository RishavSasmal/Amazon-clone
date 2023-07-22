import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLine;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLine = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return hintText;
        }
        return null;
      },
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
    );
  }
}
