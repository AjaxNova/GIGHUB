import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/controller/provider/sign_up_screen_provider.dart';
import 'package:lite_jobs/screens/auth/signUp/widgets/image_selection_widget.dart';
import 'package:lite_jobs/screens/auth/signUp/widgets/resgister_button.dart';
import 'package:lite_jobs/screens/auth/signUp/widgets/textfields_area.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, this.isGoogleSignin = false, this.user});
  final bool isGoogleSignin;

  final UserCredential? user;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<SignUpScreenProvider>(
      builder: (context, value, child) {
        return BlurryModalProgressHUD(
          inAsyncCall: value.isLoading || value.isGoogleDeleting,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitWave(
            color: singInButtonColor,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.red,
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.only(left: 19.0, bottom: 19, right: 19),
                child: registerButton(
                    user: widget.isGoogleSignin ? widget.user! : null,
                    address: addressController.text,
                    context: context,
                    isGoogleSignin: widget.isGoogleSignin,
                    size: size,
                    email: widget.isGoogleSignin
                        ? widget.user!.user!.email
                        : emailController.text,
                    name: nameController.text,
                    password: passwordController.text,
                    phone: mobileController.text),
              ),
              backgroundColor: kWhiteColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SpecialAppbar(
                      appBarTitle: "Sign Up",
                      context: context,
                      onTap: widget.isGoogleSignin
                          ? () async {
                              // User? usera = FirebaseAuth.instance.currentUser;
                              if (widget.user != null) {
                                value.changeisGoogleDeleting();
                                try {
                                  await widget.user!.user!.delete();
                                  value.changeisGoogleDeleting();
                                } on FirebaseAuthException catch (e) {
                                  log(e.toString());
                                  value.changeisGoogleDeleting();
                                }
                              }
                            }
                          : () {
                              value.clearImage();
                              Navigator.pop(context);
                            },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    imageSelectionSection(),
                    const SizedBox(
                      height: 10,
                    ),
                    textFieldArea(
                        isGoogle: widget.isGoogleSignin,
                        nameController: nameController,
                        addressController: addressController,
                        emailController: emailController,
                        mobileController: mobileController,
                        passwordController: passwordController,
                        size: size),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
