import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/auth/widget/custom_textfield.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  AuthenticationMethods authMeth = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: size.height * .53,
                    child:
                        SvgPicture.asset("assets/images/forget_password.svg"),
                  ),
                  Positioned(
                    top: 20,
                    left: 12,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const LineIcon.arrowCircleLeft(
                        size: 44,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.10),
                  child: Text(
                    "Forget password",
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
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  backgroundColor: primaryColor,
                  minimumSize: Size(size.width * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String responce =
                      await authMeth.reserPassword(emailController.text.trim());
                  setState(() {
                    isLoading = false;
                  });

                  if (responce == "Password reset email is sent") {
                    if (context.mounted) {
                      Utils().showSnackBarMessage(
                          context: context, content: responce);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (context) => const SignInPage(),
                      // ));
                    }
                  } else {
                    if (context.mounted) {
                      Utils().showSnackBarMessage(
                          context: context, content: responce);
                    }
                  }
                },
                child: Wrap(
                  children: [
                    Text(
                      "Reset Password",
                      style: GoogleFonts.inter(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 4,
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
              SizedBox(
                height: 50,
                child: Row(
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
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //   builder: (context) => const SignUpPage(),
                        // ));
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
