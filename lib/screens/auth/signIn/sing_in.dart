import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/divider_widget.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/forget_password_widget.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/register_row.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/sign_in_button.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/sign_in_with_google.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/text_field_area.dart';
import 'package:lite_jobs/screens/auth/signIn/widgets/vector_image.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<SigninProvider>(
      builder: (context, value, child) {
        return BlurryModalProgressHUD(
          inAsyncCall: value.isLoadingGoogle,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitDancingSquare(
            color: singInButtonColor,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    VectorImage(size: size),
                    TextfieldsArea(
                      size: size,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    const ForgetPasswordWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    signInbuttonWidget(
                        context: context,
                        size: size,
                        isLoading: value.isLoading,
                        email: emailController.text,
                        password: passwordController.text),
                    dividerWidget(),
                    signInWithGoogleButton(
                        size: size,
                        context: context,
                        isLoadingGoogle: value.isLoadingGoogle),
                    SizedBox(
                      height: 36,
                      child: registerRow(context),
                    )
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
