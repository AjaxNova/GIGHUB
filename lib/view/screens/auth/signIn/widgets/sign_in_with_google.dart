import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

Widget signInWithGoogleButton(
    {required Size size,
    required BuildContext context,
    required bool isLoadingGoogle}) {
  final AuthenticationMethods authenticationMethods = AuthenticationMethods();

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: test1,
        minimumSize: Size(size.width * 0.8, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: () async {
        // setState(() {
        //   isLoadingGoogle = true;
        // });
        await authenticationMethods.googleSignIn(context);

        // if (responce == "user registered") {
        //   // setState(() {
        //   //   isLoadingGoogle = false;
        //   // });
        //   if (context.mounted) {
        //     Utils().showSnackBarMessage(context: context, content: responce);
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (context) => const HomeScreen()),
        //       (route) => false,
        //     );
        //   }
        // } else {
        //   Utils().showSnackBarMessage(context: context, content: responce);
        //   // setState(() {
        //   //   isLoadingGoogle = false;
        //   // });
        // }
      },
      child: Wrap(
        children: [
          SizedBox(
              height: 25,
              child: SvgPicture.asset("assets/icons/icons8-google.svg")),
          Text(
            "Sign in with google",
            style: GoogleFonts.inter(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
