import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors/colors.dart';

Widget signInbuttonWidget(
    {required BuildContext context,
    required Size size,
    required bool isLoading,
    required String email,
    required String password}) {
  return SizedBox(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: a,
        minimumSize: Size(size.width * 0.8, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: () async {
        final provi = Provider.of<SigninProvider>(context, listen: false);
        provi.onSignInButtonClick(
            email: email, password: password, context: context);
      },
      child: Wrap(
        children: [
          Text(
            "Sign in ",
            style: GoogleFonts.inter(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}
