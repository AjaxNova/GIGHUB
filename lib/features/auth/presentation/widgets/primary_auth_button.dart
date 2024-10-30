import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {super.key,
      required this.size,
      required this.text,
      required this.onTap,
      this.isSignIn = false,
      this.isLoading = false});

  final Size size;
  final String text;
  final VoidCallback onTap;
  final bool isSignIn;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: test1,
            // const Color(0xFFE5AA17)
            minimumSize:
                isSignIn ? Size(size.width * 0.9, 50) : Size(size.width, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: onTap,
          child: Wrap(
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              if (isLoading)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xFFE5AA17),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
