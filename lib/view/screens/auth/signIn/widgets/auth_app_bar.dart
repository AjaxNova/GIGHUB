import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/common/constants/constants.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar(
      {super.key,
      required this.isBackAllowed,
      this.isSignUp = false,
      this.onTap});

  final bool isBackAllowed;
  final bool isSignUp;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white10,
            screenBackgroundColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            if (isBackAllowed)
              Row(
                children: [
                  IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: onTap,
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 34,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  )
                ],
              ),
            if (isSignUp)
              Row(
                children: [
                  Hero(
                    tag: 'image',
                    child: Image.asset(
                      height: 30,
                      'assets/images/login_image.png',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Hero(
                    tag: 'text',
                    child: Text(
                      "GIGHUB",
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
