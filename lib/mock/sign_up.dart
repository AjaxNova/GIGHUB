// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:image_picker/image_picker.dart';

// class MockSignUpPage extends StatefulWidget {
//   const MockSignUpPage({super.key});

//   @override
//   _MockSignUpPageState createState() => _MockSignUpPageState();
// }

// class _MockSignUpPageState extends State<MockSignUpPage> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   File? _image;

//   Future<void> _getImage(ImageSource source) async {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     setState(() {
//       _image = File(pickedImage!.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign-Up Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: FormBuilder(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   FormBuilderTextField(
//                     name: 'name',
//                     decoration: const InputDecoration(labelText: 'Name'),
//                     validator: (value) {
//                       return null;
//                     },
//                   ),
//                   FormBuilderTextField(
//                     name: 'password',
//                     decoration: const InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     validator: (value) {
//                       return null;
//                     },
//                   ),
//                   FormBuilderTextField(
//                     name: 'phone',
//                     decoration:
//                         const InputDecoration(labelText: 'Phone Number'),
//                     keyboardType: TextInputType.phone,
//                     validator: (value) {
//                       return null;
//                     },
//                   ),
//                   FormBuilderTextField(
//                     name: 'email',
//                     decoration: const InputDecoration(labelText: 'Email'),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       return null;
//                     },
//                   ),
//                   ElevatedButton(
//                     onPressed: () => _getImage(ImageSource.camera),
//                     child: const Text('Pick Image from Camera'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => _getImage(ImageSource.gallery),
//                     child: const Text('Pick Image from Gallery'),
//                   ),
//                   _image != null
//                       ? Image.file(
//                           _image!,
//                           height: 100,
//                           width: 100,
//                         )
//                       : const SizedBox(),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.saveAndValidate()) {
//                         // Perform your sign-up logic here
//                         // Access form values like this: _formKey.currentState!.fields['name'].value
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.5),
//                       elevation: 5,
//                       shadowColor: Colors.black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
