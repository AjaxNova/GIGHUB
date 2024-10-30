// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lite_jobs/common/constants/constants.dart';
// import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
// import 'package:lite_jobs/server/auth/auth_functions.dart';
// import 'package:lite_jobs/utils/utils.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/auth_app_bar.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/divider_widget.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/forget_password_widget.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/register_row.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/sign_in_button.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/sign_in_with_google.dart';
// import 'package:provider/provider.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key, this.isBackAllowed});

//   final bool? isBackAllowed;

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   AuthenticationMethods authenticationMethods = AuthenticationMethods();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     super.dispose();
//     passwordController.dispose();
//     emailController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Consumer<SigninProvider>(
//       builder: (context, value, child) {
//         return PopScope(
//           onPopInvoked: (didPop) {
//             if (didPop == false) {
//               Utils().showSnackBarMessage(
//                   context: context,
//                   content: "cant go back while loading",
//                   color: Colors.red.shade300);
//             }
//           },
//           canPop: value.isBackAllowed,
//           child: SafeArea(
//             child: Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: Size(size.width * 0.75, size.height * .070),
//                 child: AuthAppBar(
//                   isBackAllowed: widget.isBackAllowed ?? false,
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 child: Container(
//                   decoration: scaffoldBoxDecoration,
//                   height: size.height - size.height * .070,
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 30.0, vertical: 10),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Color(0xFFD8EAFF),
//                                     Color(0xFFD8EAFF)
//                                   ],
//                                 ),
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(10)),
//                             height: size.height * 0.13,
//                             width: size.width,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Hero(
//                                   tag: 'image',
//                                   child: Image.asset(
//                                     height: 50,
//                                     'assets/images/login_image.png',
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Text(
//                                   "GIGHUB",
//                                   style: GoogleFonts.inter(
//                                       fontSize: 30,
//                                       letterSpacing: 1.5,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                           child: Card(
//                             color: Colors.white54,
//                             surfaceTintColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             elevation: 5,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(color: Colors.white54)),
//                               height: size.height * 0.35,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // Text(
//                                     //   "Sign In",
//                                     //   style: GoogleFonts.inter(
//                                     //     fontWeight: FontWeight.w500,
//                                     //     fontSize: 30,
//                                     //   ),
//                                     // ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     AuthTextfield(
//                                         controller: emailController,
//                                         value: value,
//                                         hintText: "email",
//                                         iconType: IconType.email),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     AuthTextfield(
//                                       controller: passwordController,
//                                       value: value,
//                                       hintText: "password",
//                                       iconType: IconType.password,
//                                       isPassword: true,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const ForgetPasswordWidget(),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         signInbuttonWidget(
//                             formKey: _formKey,
//                             context: context,
//                             size: size,
//                             isLoading: value.isLoading,
//                             email: emailController,
//                             password: passwordController),
//                         dividerWidget(),
//                         signInWithGoogleButton(
//                             size: size,
//                             context: context,
//                             isLoadingGoogle: value.isLoadingGoogle),
//                         SizedBox(
//                           height: 36,
//                           child: registerRow(context),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // class AurhAppBar extends StatelessWidget {
// //   const AurhAppBar({super.key, required this.size, this.isBackAllowed});

// //   final Size size;

// //   final bool? isBackAllowed;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [
// //               Colors.white10,
// //               screenBackgroundColor,
// //             ]),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
// //         child: Stack(
// //           children: [
// //             isBackAllowed != null && isBackAllowed == true
// //                 ? Align(
// //                     alignment: Alignment.topLeft,
// //                     child: IconButton(
// //                       onPressed: () {
// //                         log("pressed");
// //                         Navigator.pop(context);
// //                       },
// //                       icon: const Icon(
// //                         Icons.arrow_circle_left_outlined,
// //                         size: 34,
// //                       ),
// //                     ),
// //                   )
// //                 : const SizedBox(),
// //             Align(
// //               alignment: Alignment.center,
// //               child: VectorImage(size: size),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class AuthTextfield extends StatelessWidget {
//   final SigninProvider value;
//   final bool isPassword;
//   final IconType iconType;
//   final String hintText;
//   final TextEditingController controller;

//   const AuthTextfield(
//       {super.key,
//       required this.value,
//       required this.hintText,
//       required this.iconType,
//       required this.controller,
//       this.isPassword = false});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: (fieldVal) => validateInput(fieldVal, iconType),
//       obscureText: isPassword ? value.isObscure : false,
//       decoration: InputDecoration(
//           suffixIcon: isPassword
//               ? IconButton(
//                   onPressed: () {
//                     value.obscureClicked();
//                   },
//                   icon: Icon(
//                     value.isObscure
//                         ? Icons.visibility_off_rounded
//                         : Icons.visibility_rounded,
//                     color: Colors.grey[500],
//                   ),
//                 )
//               : const SizedBox(),
//           prefixIcon: getIconForType(iconType),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
//           contentPadding: const EdgeInsets.all(17),
//           enabledBorder: authFieldOutlineInputBorder,
//           focusedBorder: authFieldOutlineInputBorder,
//           errorBorder: authFieldErrorOutlineInputBorder,
//           focusedErrorBorder: authFieldErrorOutlineInputBorder),
//     );
//   }
// }

// // class AuthInputColumn extends StatelessWidget {
// //   const AuthInputColumn({
// //     super.key,
// //     required this.size,
// //     required this.emailController,
// //     required this.passwordController,
// //   });

// //   final Size size;
// //   final TextEditingController emailController;
// //   final TextEditingController passwordController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Align(
// //           alignment: Alignment.topLeft,
// //           child: Container(
// //             margin: EdgeInsets.only(left: size.width * 0.10),
// //             child: const Text(
// //               "Sign In",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: 25,
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(
// //           height: 20,
// //         ),
// //         CustomTextfieldWidget(
// //           hintText: "email",
// //           size: size,
// //           controller: emailController,
// //         ),
// //         const SizedBox(
// //           height: 8,
// //         ),
// //         CustomTextfieldWidget(
// //           hintText: "password",
// //           size: size,
// //           controller: passwordController,
// //           obscure: true,
// //         ),
// //       ],
// //     );
// //   }
// // }

// class AuthInputField extends StatelessWidget {
//   const AuthInputField(
//       {super.key,
//       required this.size,
//       required this.controller,
//       this.obscure = false,
//       required this.hintText,
//       this.maxLines = 1});
//   final bool obscure;
//   final Size size;
//   final TextEditingController controller;
//   final String hintText;
//   final int maxLines;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: SizedBox(
//           width: size.width * 0.8,
//           child: TextField(
//             maxLines: maxLines,
//             obscureText: obscure,
//             controller: controller,
//             decoration: InputDecoration(
//                 hintText: hintText,
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
//           )),
//     );
//   }
// }


// /*
//     import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
// import 'package:lite_jobs/server/auth/auth_functions.dart';
// import 'package:lite_jobs/utils/colors/colors.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/divider_widget.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/forget_password_widget.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/register_row.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/sign_in_button.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/sign_in_with_google.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/text_field_area.dart';
// import 'package:lite_jobs/view/screens/auth/signIn/widgets/vector_image.dart';
// import 'package:provider/provider.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   AuthenticationMethods authenticationMethods = AuthenticationMethods();

//   @override
//   void dispose() {
//     super.dispose();
//     passwordController.dispose();
//     emailController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Consumer<SigninProvider>(
//       builder: (context, value, child) {
//         return BlurryModalProgressHUD(
//           inAsyncCall: value.isLoadingGoogle,
//           blurEffectIntensity: 4,
//           progressIndicator: const SpinKitDancingSquare(
//             color: singInButtonColor,
//             size: 90.0,
//           ),
//           dismissible: false,
//           opacity: 0.4,
//           color: Colors.black,
//           child: SafeArea(
//             child: Scaffold(
//               backgroundColor: Colors.white,
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     VectorImage(size: size),
//                     TextfieldsArea(
//                       size: size,
//                       emailController: emailController,
//                       passwordController: passwordController,
//                     ),
//                     const ForgetPasswordWidget(),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     signInbuttonWidget(
//                         context: context,
//                         size: size,
//                         isLoading: value.isLoading,
//                         email: emailController.text,
//                         password: passwordController.text),
//                     dividerWidget(),
//                     signInWithGoogleButton(
//                         size: size,
//                         context: context,
//                         isLoadingGoogle: value.isLoadingGoogle),
//                     SizedBox(
//                       height: 36,
//                       child: registerRow(context),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

//      */
