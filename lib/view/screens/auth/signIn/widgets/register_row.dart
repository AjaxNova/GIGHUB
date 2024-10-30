import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/features/auth/presentation/pages/sign_up_screen.dart';

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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignUpScreen()
                  // SignUpPage(),
                  ));
        },
        child: Text(
          "Register",
          style: GoogleFonts.inter(
            fontSize: 13,
            letterSpacing: 1.4,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = const Color(0xFFE5AA17),
          ),
        ),
      )
    ],
  );
}
