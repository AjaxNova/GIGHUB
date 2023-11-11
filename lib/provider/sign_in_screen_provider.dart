import 'package:flutter/material.dart';
import 'package:lite_jobs/provider/auth_provider.dart';
import 'package:lite_jobs/screens/finishYourProfile/finish_your_profile_page.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../screens/mainJobScreen/main_screen.dart';

class SigninProvider extends ChangeNotifier {
  final AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  bool isLoadingGoogle = false;

  changeIsLoading() {
    if (isLoading == true) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    notifyListeners();
  }

  onSignInButtonClick({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    changeIsLoading();
    String responce = await authenticationMethods.signInUser(
        email: email, password: password);
    changeIsLoading();

    if (responce == "signed In Succesfully ") {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      await authProvider.refreshUser();

      if (context.mounted) {
        Utils().showSnackBarMessage(context: context, content: responce);
        if (authProvider.getUserModel.finishProfile == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => FinishYourProfilePage(
                      userModel: authProvider.getUserModel,
                    )),
            (route) => false,
          );
        }
      }
    } else {
      if (context.mounted) {
        Utils().showSnackBarMessage(context: context, content: responce);
      }
    }
  }
}
