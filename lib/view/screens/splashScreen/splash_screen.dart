// import 'package:flutter/material.dart';
// import 'package:lite_jobs/controller/provider/auth_provider.dart';
// import 'package:lite_jobs/view/screens/finishYourProfile/finish_your_profile_page.dart';
// import 'package:lite_jobs/view/screens/mainJobScreen/main_screen.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     navigateToHome(context);
//     return const Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           ),
//           Center(
//             child: Text(
//               "JobTok",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void navigateToHome(context) async {
//     AuthProviderData authProvider =
//         Provider.of<AuthProviderData>(context, listen: false);
//     await authProvider.refreshUser();

//     if (authProvider.getUserModel.finishProfile == true) {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const HomeScreen()));
//     } else {
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => FinishYourProfilePage(
//                 userModel: authProvider.getUserModel,
//               )));
//     }
//   }
// }
