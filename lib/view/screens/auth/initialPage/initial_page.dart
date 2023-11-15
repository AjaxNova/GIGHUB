import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/screens/auth/signIn/sing_in.dart';
import 'package:lite_jobs/screens/auth/signUp/sing_up.dart';
import 'package:lite_jobs/screens/auth/widget/custom_button.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

import '../../../utils/utils.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: SizedBox(
        //   width: size.width * 0.3,
        //   height: size.height * 0.3,
        //   child: Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(28.0),
        //       child: SizedBox(
        //         height: size.height * 0.15,
        //         // color: Colors.yellow,
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: Container(
        //                 height: size.height * 0.10,
        //                 decoration: BoxDecoration(
        //                     color: test1,
        //                     borderRadius: BorderRadius.circular(10)),
        //               ),
        //             ),
        //             Expanded(
        //               child: Container(
        //                 height: size.height * 0.10,
        //                 decoration: BoxDecoration(
        //                     color: test2,
        //                     borderRadius: BorderRadius.circular(10)),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.022),
              SizedBox(
                height: size.height * .46,
                child: SvgPicture.asset("assets/images/initial_1.svg"),
              ),
              Text(
                "Find Instant ",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 29,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "Jobs For You",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 29,
                ),
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              SizedBox(
                width: size.width * 0.59,
                child: Center(
                  child: Text(
                    "Explore all available jobs near you and choose according to your interest",
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      wordSpacing: .5,
                      letterSpacing: .1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  CustomButton(
                    buttonText: "Sign Up",
                    elevation: 3,
                    color: kWhiteColor,
                    borderColor: kWhiteColor,
                    onTap: () {
                      Utils().navigateMe(
                          context: context, page: const SignUpPage());
                    },
                  ),
                  CustomButton(
                    key: key ?? key,
                    buttonText: "Sign In",
                    elevation: 2,
                    color: customGreyColor,
                    borderColor: kGreyColor,
                    onTap: () {
                      Utils().navigateMe(
                          context: context, page: const SignInPage());
                    },
                  ),
                  const Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
