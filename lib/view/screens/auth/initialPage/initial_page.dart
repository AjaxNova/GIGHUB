import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFD8EAFF), Color(0xFFD8EAFF)],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // SizedBox(height: size.height * 0.2),
              SizedBox(
                height: size.height * .46,
                child: const Image(
                    image: AssetImage(
                        "assets/images/initial_1-removebg-preview.png")),
                // child: SvgPicture.asset(
                //     "assets/images/initial_1-removebg-preview.svg"),
              ),
              Text(
                "Find Jobs - Post Jobs",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "All in one GIGHUB",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              SizedBox(
                width: size.width * 0.59,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
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
                height: size.height * 0.10,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InstantScreenButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonsForInstant extends StatelessWidget {
  const ButtonsForInstant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

        //top offset: Offset(2, -4),  bot offset: Offset(-4, 2)
        boxShadow: const [
          BoxShadow(
              offset: Offset(2, -4),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.black87),
          BoxShadow(
            offset: Offset(-4, 2),
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.deepPurple,
          )
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.orangeAccent, Colors.orangeAccent[100]!]),
      ),
    );
  }
}

class InstantScreenButton extends StatelessWidget {
  const InstantScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils().navigateMe(
            context: context,
            page: const SignInScreen(
              isBackAllowed: true,
            ));
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width / 1.23,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 13,
              blurRadius: 4,
              color: Colors.white24,
            )
          ],
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFFE5AA17),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's get started",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.arrow_circle_right_outlined,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
