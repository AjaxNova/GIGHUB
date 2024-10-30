// import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
// import 'package:lite_jobs/controller/provider/finish_your_profile_provider.dart';
// import 'package:lite_jobs/features/splashScreen/domain/entities/user_model_entity.dart';
// import 'package:lite_jobs/utils/colors/colors.dart';
// import 'package:lite_jobs/utils/utils.dart';
// import 'package:provider/provider.dart';

// import '../auth/widget/custom_textfield.dart';
// import '../mainJobScreen/main_screen.dart';

// class FinishYourProfilePage extends StatefulWidget {
//   const FinishYourProfilePage({super.key, required this.userModel});

//   final UserModelEntity userModel;

//   @override
//   State<FinishYourProfilePage> createState() => _FinishYourProfilePageState();
// }

// class _FinishYourProfilePageState extends State<FinishYourProfilePage> {
//   final TextEditingController _skillContoller = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();

//   final TextEditingController _highestQualification = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = widget.userModel.username;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _skillContoller.dispose();
//     _nameController.dispose();
//     _highestQualification.dispose();
//     _bioController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Consumer<FinishYourProfileProvider>(
//       builder: (context, valueProfile, child) {
//         return BlurryModalProgressHUD(
//             inAsyncCall: valueProfile.isLoading,
//             blurEffectIntensity: 4,
//             progressIndicator: const SpinKitWave(
//               color: singInButtonColor,
//               size: 90.0,
//             ),
//             dismissible: false,
//             opacity: 0.4,
//             color: Colors.black,
//             child: SafeArea(
//               child: Scaffold(
//                 bottomNavigationBar: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: () async {
//                       if (valueProfile.skill.isEmpty) {
//                         Utils().showSnackBarMessage(
//                             context: context, content: "fill all the fields");
//                       } else {
//                         if (_formKey.currentState!.validate()) {
//                           valueProfile.changeIsLoading();
//                           final String res = await valueProfile.onFinishButton(
//                               bio: _bioController.text,
//                               age: _ageController.text,
//                               qualification: _highestQualification.text,
//                               uid: widget.userModel.uid);
//                           if (res == "success") {
//                             valueProfile.resetValues();
//                             _ageController.clear();
//                             _skillContoller.clear();
//                             _highestQualification.clear();
//                             _bioController.clear();
//                           }
//                           valueProfile.changeIsLoading();
//                           Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                                 builder: (context) => const HomeScreen()),
//                             (route) => false,
//                           );
//                         } else {
//                           Utils().showSnackBarMessage(
//                               context: context,
//                               content: "fill the remaingn fields");
//                         }
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: test1,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Center(
//                           child: Text(
//                         "Finish",
//                         style: GoogleFonts.inter(
//                             fontSize: 27, fontWeight: FontWeight.bold),
//                       )),
//                     ),
//                   ),
//                 ),
//                 appBar: SpecialAppbar(
//                     isProfile: true,
//                     context: context,
//                     onTap: () {},
//                     appBarTitle: "Finish Your Profile"),
//                 body: SingleChildScrollView(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 18.0, right: 18, top: 18),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             imagePart(widget.userModel.photoUrl),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                               readOnly: true,
//                               controller: _nameController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Name',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             TextFormField(
//                               controller: _bioController,
//                               decoration: const InputDecoration(
//                                 labelText: 'bio',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.black),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please fill the field';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             DropdownButtonFormField(
//                               value: valueProfile.gender,
//                               onChanged: (value) {
//                                 valueProfile.setGender(value!);
//                               },
//                               items: ["Male", "Female"]
//                                   .map<DropdownMenuItem<String>>(
//                                 (String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 },
//                               ).toList(),
//                               decoration: const InputDecoration(
//                                 labelText: 'Gender',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             TextFormField(
//                               inputFormatters: [
//                                 LengthLimitingTextInputFormatter(2)
//                               ],
//                               keyboardType: TextInputType.number,
//                               controller: _ageController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Age',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.black),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please fill the field';
//                                 } else if (int.parse(value) < 18) {
//                                   return 'age should be above 18';
//                                 }

//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             TextFormField(
//                               controller: _highestQualification,
//                               decoration: const InputDecoration(
//                                 labelText: 'Highest Qualification',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.black),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please fill the field';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Card(
//                               color: Colors.white,
//                               elevation: 4,
//                               shadowColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Skills:',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 15),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 8.0, right: 8, bottom: 15),
//                                       child: Column(
//                                         children: valueProfile.skill
//                                             .asMap()
//                                             .entries
//                                             .map(
//                                               (entry) => Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     bottom: 1),
//                                                 child: SizedBox(
//                                                   child: ListTile(
//                                                     leading: SizedBox(
//                                                       width: size.width * 0.3,
//                                                       child: Text(
//                                                         ". ${entry.value}",
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                                 fontSize: 16),
//                                                       ),
//                                                     ),
//                                                     trailing: IconButton(
//                                                       onPressed: () {
//                                                         valueProfile
//                                                             .removeFromSkills(
//                                                                 entry.key);
//                                                       },
//                                                       icon: const FaIcon(
//                                                         FontAwesomeIcons
//                                                             .circleXmark,
//                                                         size: 21,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           flex: 4,
//                                           child: TextFormField(
//                                             maxLines: 3,
//                                             controller: _skillContoller,
//                                             decoration: const InputDecoration(
//                                               labelText: 'skills',
//                                               hintStyle: TextStyle(
//                                                   color: Colors.black),
//                                               labelStyle: TextStyle(
//                                                   color: Colors.black),
//                                               errorBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.red),
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.black),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.black),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 1,
//                                           child: IconButton(
//                                             onPressed: () {
//                                               valueProfile.addToListSkill(
//                                                   _skillContoller.text);
//                                               _skillContoller.clear();
//                                             },
//                                             icon: const Icon(Icons.add_box,
//                                                 size: 52),
//                                             style: ElevatedButton.styleFrom(
//                                               foregroundColor: Colors.black,
//                                               backgroundColor: test1,
//                                               elevation: 4,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15.0),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }

// Column imagePart(String photoUrl) {
//   return Column(
//     children: [
//       Consumer<FinishYourProfileProvider>(
//         builder: (context, value, child) {
//           return CircleAvatar(
//             backgroundColor: singUPButtonColor,
//             radius: 77,
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 72,
//               backgroundImage: NetworkImage(photoUrl),
//             ),
//           );
//         },
//       )
//     ],
//   );
// }

// Column fieldPart(
//     {required bool isGoogle,
//     required Size size,
//     required TextEditingController nameController,
//     passwordController,
//     addressController,
//     mobileController,
//     emailController}) {
//   return Column(
//     children: [
//       CustomTextfieldWidget(
//         hintText: "name",
//         size: size,
//         controller: nameController,
//       ),
//     ],
//   );
// }
