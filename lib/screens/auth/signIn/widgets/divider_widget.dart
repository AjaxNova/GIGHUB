import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget dividerWidget() {
  return SizedBox(
    height: 30,
    child: Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "Or",
          style: GoogleFonts.inter(fontSize: 13),
        ),
        const SizedBox(
          width: 5,
        ),
        const Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    ),
  );
}
