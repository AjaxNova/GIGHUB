// import 'package:flutter/material.dart';
// import 'package:lite_jobs/controller/provider/auth_provider.dart';
// import 'package:lite_jobs/server/auth/auth_functions.dart';
// import 'package:lite_jobs/utils/utils.dart';
// import 'package:lite_jobs/view/screens/finishYourProfile/finish_your_profile_page.dart';
// import 'package:lite_jobs/view/screens/mainJobScreen/main_screen.dart';
// import 'package:provider/provider.dart';

// class SigninProvider extends ChangeNotifier {
//   final AuthenticationMethods authenticationMethods = AuthenticationMethods();
//   bool isLoading = false;
//   bool isLoadingGoogle = false;
//   bool isObscure = true;

//   bool hasError = false;

//   bool isBackAllowed = true;

//   changeTextfieldErrorStatus() {
//     hasError = true;
//     notifyListeners();
//   }

//   initAuthError() {
//     hasError = false;
//     notifyListeners();
//   }

//   obscureClicked() {
//     if (isObscure) {
//       isObscure = false;
//     } else {
//       isObscure = true;
//     }
//     notifyListeners();
//   }

//   loadingOn() {
//     isLoading = true;
//     isBackAllowed = false;
//     notifyListeners();
//   }

//   loadingOff() {
//     isLoading = false;
//     isBackAllowed = true;
//     notifyListeners();
//   }

//   onSignInButtonClick({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     loadingOn();

//     String responce = await authenticationMethods.signInUser(
//         email: email, password: password);

//     if (responce == "signed In Succesfully ") {
//       AuthProviderData authProvider =
//           Provider.of<AuthProviderData>(context, listen: false);
//       await authProvider.refreshUser();

//       if (context.mounted) {
//         Utils().showSnackBarMessage(context: context, content: responce);
//         if (authProvider.getUserModel.finishProfile == true) {
//           loadingOff();

//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//             (route) => false,
//           );
//         } else {
//           loadingOff();

//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => FinishYourProfilePage(
//                       userModel: authProvider.getUserModel,
//                     )),
//             (route) => false,
//           );
//         }
//       }
//     } else {
//       loadingOff();

//       if (context.mounted) {
//         Utils().showSnackBarMessage(context: context, content: responce);
//       }
//     }
//   }
// }
