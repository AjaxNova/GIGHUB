import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/custom_textfield.dart';

class TextfieldsArea extends StatelessWidget {
  const TextfieldsArea({
    super.key,
    required this.size,
    required this.emailController,
    required this.passwordController,
  });

  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: size.width * 0.10),
            child: Text(
              "Sign In",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextfieldWidget(
          hintText: "email",
          size: size,
          controller: emailController,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextfieldWidget(
          hintText: "password",
          size: size,
          controller: passwordController,
          obscure: true,
        ),
      ],
    );
  }
}
