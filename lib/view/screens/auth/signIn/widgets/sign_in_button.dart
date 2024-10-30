// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lite_jobs/common/constants/constants.dart';
// import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
// import 'package:provider/provider.dart';

// Widget signInbuttonWidget(
//     {required BuildContext context,
//     required Size size,
//     required bool isLoading,
//     required TextEditingController email,
//     required TextEditingController password,
//     required GlobalKey<FormState> formKey}) {
//   return SizedBox(
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         elevation: 2,
// //        backgroundColor: a,

//         backgroundColor: const Color(0xFFE5AA17),
//         minimumSize: Size(size.width * 0.8, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6),
//         ),
//       ),
//       onPressed: () async {
//         final provi = Provider.of<SigninProvider>(context, listen: false);

//         bool val = submitForm(formKey);
//         if (val) {
//           provi.onSignInButtonClick(
//               email: email.text, password: password.text, context: context);
//         } else {
//           if (!provi.hasError) {
//             provi.changeTextfieldErrorStatus();
//             return;
//           }

//           return;
//         }
//       },
//       child: Wrap(
//         children: [
//           Text(
//             "Sign in ",
//             style: GoogleFonts.inter(
//                 fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black),
//           ),
//           isLoading
//               ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 )
//               : const SizedBox()
//         ],
//       ),
//     ),
//   );
// }
