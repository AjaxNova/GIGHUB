import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite_jobs/common/constants/constants.dart';
import 'package:lite_jobs/core/utils/snack_bar.dart';
import 'package:lite_jobs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/primary_auth_button.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/sign_up_auth_section.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/sign_up_image_section.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/view/screens/auth/signIn/widgets/auth_app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.isGoogleSignin = false, this.user});
  final bool isGoogleSignin;

  final UserCredential? user;

  @override
  State<SignUpScreen> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AuthBloc>().add(InitAuthInitial());

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
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<AuthBloc>().add(SingUpBackButton());
      },
      child: SafeArea(
        child: Container(
          decoration: scaffoldBoxDecoration,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, size.height * 0.07),
              child: AuthAppBar(
                isBackAllowed: true,
                isSignUp: true,
                onTap: () {
                  context.read<AuthBloc>().add(SingUpBackButton());
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            body: BlocConsumer<AuthBloc, AuthBlocState>(
              listener: (context, state) {
                if (state is SignUpSuccessState) {
                  customSnackBar(
                      scaffoldMessenger,
                      'Registered successfully',
                      Colors.green.shade800,
                      Colors.white,
                      const TextStyle(color: Colors.black));

                  Navigator.of(context).pop();
                }
                if (state is SignUpFailedState) {
                  customSnackBar(
                      scaffoldMessenger,
                      state.msg,
                      Colors.red.shade800,
                      Colors.white,
                      const TextStyle(color: Colors.white));
                }
                if (state is SignUpImageErrorState) {
                  customSnackBar(
                      scaffoldMessenger,
                      state.text,
                      Colors.red.shade800,
                      Colors.white,
                      const TextStyle(color: Colors.white));
                }
              },
              builder: (context, state) {
                log('current state $state');

                if (state is AuthBlocInitial ||
                    state is SignUpImageLoadingState ||
                    state is SignUpImageFetchedState ||
                    state is SignUpFailedState ||
                    state is SignUpImageErrorState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //the image section
                        const SignUpImageSection(),
                        //authfields
                        SignUpAuthSection(
                            formKey: _formKey,
                            size: size,
                            nameController: nameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            mobileController: mobileController,
                            addressController: addressController),

                        ///register button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RegisterButton(
                            onTap: () async {
                              log('pressed');
                              if (_formKey.currentState!.validate()) {
                                if (state is SignUpImageFetchedState ||
                                    state is SignUpFailedState) {
                                  final Uint8List? file;
                                  if (state is SignUpImageFetchedState) {
                                    file = state.image;
                                  } else if (state is SignUpFailedState) {
                                    file = state.file;
                                  } else {
                                    file = null;
                                  }
                                  context.read<AuthBloc>().add(SignUpEvent(
                                      address: addressController.text,
                                      email: emailController.text,
                                      fetchImage: file,
                                      isGoogleSignin: false,
                                      name: nameController.text,
                                      password: passwordController.text,
                                      phone: mobileController.text));
                                } else {
                                  customSnackBar(
                                      scaffoldMessenger,
                                      'Add a Photo',
                                      Colors.red.shade800,
                                      Colors.white,
                                      const TextStyle(color: Colors.white));
                                }
                              }
                            },
                            size: size,
                            text: "Sign Up",
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  );
                }
                if (state is SignUpLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
