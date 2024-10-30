import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite_jobs/core/utils/snack_bar.dart';
import 'package:lite_jobs/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:lite_jobs/features/finishYourProfile/presentation/pages/finish_your_profile_page.dart';
import 'package:lite_jobs/features/splashScreen/presentation/bloc/splash_screen_bloc.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashScreenBloc>().add(CheckUserAndNavigateHome());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashFailedState) {
          customSnackBar(
              scaffoldMessenger,
              state.msg.replaceAll('Exception: ', ''),
              Colors.red.shade800,
              Colors.white,
              const TextStyle(color: Colors.white));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SignInScreen(
                isBackAllowed: false,
              ),
            ),
            (route) => false,
          );
        }
        if (state is SplashSuccessState) {
          if (state.user.finishProfile == true) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => FinishYourProfilePage(
                    userModel: state.user,
                  ),
                ),
                (route) => false);
          }
        }
      },
      builder: (context, state) {
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              Center(
                child: Text(
                  "JobTok",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void navigateToHome(context) async {
  //   AuthProviderData authProvider =
  //       Provider.of<AuthProviderData>(context, listen: false);
  //   await authProvider.refreshUser();

  //   if (authProvider.getUserModel.finishProfile == true) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   } else {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => FinishYourProfilePage(
  //               userModel: authProvider.getUserModel,
  //             )));
  //   }
  // }
}
