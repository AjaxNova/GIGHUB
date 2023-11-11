import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors/colors.dart';
import '../../signUp/sing_up.dart';

Row registerRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Dont have a account yet?",
      ),
      const SizedBox(
        width: 5,
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SignUpPage(),
          ));
        },
        child: Text(
          "Register",
          style: GoogleFonts.inter(
            letterSpacing: 1.4,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2.0
              ..color = singInButtonColor,
          ),
        ),
      )
    ],
  );
}
