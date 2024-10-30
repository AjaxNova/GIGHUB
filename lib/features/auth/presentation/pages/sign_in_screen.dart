import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/common/constants/constants.dart';
import 'package:lite_jobs/core/utils/snack_bar.dart';
import 'package:lite_jobs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/primary_auth_button.dart';
import 'package:lite_jobs/features/finishYourProfile/presentation/pages/finish_your_profile_page.dart';
import 'package:lite_jobs/features/home/presentation/pages/home_screen.dart';
import 'package:lite_jobs/view/screens/auth/signIn/widgets/auth_app_bar.dart';
import 'package:lite_jobs/view/screens/auth/signIn/widgets/divider_widget.dart';
import 'package:lite_jobs/view/screens/auth/signIn/widgets/forget_password_widget.dart';
import 'package:lite_jobs/view/screens/auth/signIn/widgets/register_row.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, this.isBackAllowed});

  final bool? isBackAllowed;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AuthBloc>().add(InitAuthInitial());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          customSnackBar(
              scaffoldMessenger,
              'Logged in successfully',
              Colors.green.shade800,
              Colors.white,
              const TextStyle(color: Colors.black));
          if (state.userModel.finishProfile == false) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => FinishYourProfilePage(
                  userModel: state.userModel,
                ),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          }
        }
        if (state is SignInFailedState) {
          customSnackBar(
              scaffoldMessenger,
              state.msg.replaceAll('Exception: ', ''),
              Colors.red.shade800,
              Colors.white,
              const TextStyle(color: Colors.white));
        }
      },
      builder: (context, state) {
        if (state is AuthBlocInitial ||
            state is SignInFailedState ||
            state is SignInSuccessState ||
            state is SignInLoadingState) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(size.width * 0.75, size.height * .070),
                child: AuthAppBar(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  isBackAllowed: widget.isBackAllowed ?? false,
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: scaffoldBoxDecoration,
                  height: size.height - size.height * .070,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFD8EAFF),
                                    Color(0xFFD8EAFF)
                                  ],
                                ),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: 'image',
                                  child: Image.asset(
                                    height: size.height * 0.08,
                                    'assets/images/login_image.png',
                                  ),
                                ),
                                Text(
                                  "GIGHUB",
                                  style: GoogleFonts.inter(
                                      fontSize: 30,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: Colors.white54,
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white54)),
                              height: size.height * 0.35,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    CustomAuthTextField(
                                        controller: emailController,
                                        iconType: IconType.email,
                                        hintText: 'email'),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    CustomAuthTextField(
                                        isPassword: true,
                                        controller: passwordController,
                                        iconType: IconType.password,
                                        hintText: 'password')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const ForgetPasswordWidget(),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        RegisterButton(
                          isLoading: state is SignInLoadingState,
                          size: size,
                          text: 'Sign In',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(SignInEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ));
                            }
                          },
                          isSignIn: true,
                        ),
                        dividerWidget(),
                        // signInWithGoogleButton(
                        //     size: size,
                        //     context: context,
                        //     isLoadingGoogle: value.isLoadingGoogle),
                        SizedBox(
                          height: 36,
                          child: registerRow(context),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox(
          child: Center(
            child: Text("Something went wrong"),
          ),
        );
      },
    );
  }
}
