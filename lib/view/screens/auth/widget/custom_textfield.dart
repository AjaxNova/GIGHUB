import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  const CustomTextfieldWidget(
      {super.key,
      required this.size,
      required this.controller,
      this.obscure = false,
      required this.hintText,
      this.maxLines = 1});
  final bool obscure;
  final Size size;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
          width: size.width * 0.8,
          child: TextField(
            maxLines: maxLines,
            obscureText: obscure,
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
          )),
    );
  }
}
