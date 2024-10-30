// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lite_jobs/controller/provider/sign_up_screen_provider.dart';
// import 'package:lite_jobs/utils/colors/colors.dart';
// import 'package:provider/provider.dart';

// ElevatedButton registerButton(
//     {required Size size,
//     required BuildContext context,
//     required bool isGoogleSignin,
//     required String address,
//     UserCredential? user,
//     required name,
//     email,
//     phone,
//     password}) {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       elevation: 2,
//       backgroundColor: test1,
//       minimumSize: Size(size.width * 0.8, 50),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(6),
//       ),
//     ),
//     onPressed: () async {
//       final prov = Provider.of<SignUpScreenProvider>(context, listen: false);
//       prov.onregisterbutton(
//         isGoogleSignin: isGoogleSignin,
//         address: address,
//         name: name,
//         email: email,
//         phone: phone,
//         password: password,
//         context: context,
//       );
//     },
//     child: Consumer<SignUpScreenProvider>(
//       builder: (context, value, child) {
//         return Wrap(
//           children: [
//             Text(
//               "Register",
//               style: GoogleFonts.inter(
//                   fontSize: 19,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             value.isLoading
//                 ? const SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   )
//                 : const SizedBox(),
//           ],
//         );
//       },
//     ),
//   );
// }
