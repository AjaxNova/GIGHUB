import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/provider/sign_up_screen_provider.dart';
import '../screens/auth/functions/pick_image.dart';
import '../screens/auth/widget/custom_textfield.dart';

class SignUpScreenPage extends StatefulWidget {
  const SignUpScreenPage({Key? key, this.isGoogleSignin = false, this.user})
      : super(key: key);

  final bool isGoogleSignin;
  final UserCredential? user;

  @override
  _SignUpScreenPageState createState() => _SignUpScreenPageState();
}

class _SignUpScreenPageState extends State<SignUpScreenPage> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController mobileController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<SignUpScreenProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildProfileImageSection(context, value),
                    const SizedBox(height: 30),
                    _buildTextFieldArea(context, size),
                    const SizedBox(height: 30),
                    _buildSignUpButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Create an Account",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildProfileImageSection(
      BuildContext context, SignUpScreenProvider value) {
    return GestureDetector(
      onTap: () async {
        value.changeIsImageLoading();
        final file = await pickImage(ImageSource.gallery, context);
        if (file != null) {
          value.setImage(file);
        }
        value.changeIsImageLoading();
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: const CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage("assets/images/default_person_3.png")),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: singUPButtonColor,
            child: Icon(
              value.fetchImage != null ? Icons.edit_outlined : Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldArea(BuildContext context, Size size) {
    return Column(
      children: [
        CustomTextfieldWidget(
          hintText: "Full Name",
          size: size,
          controller: nameController,
        ),
        const SizedBox(height: 15),
        CustomTextfieldWidget(
          hintText: "Password",
          size: size,
          controller: passwordController,
          obscure: true,
        ),
        const SizedBox(height: 15),
        CustomTextfieldWidget(
          hintText: "Phone Number",
          size: size,
          controller: mobileController,
        ),
        const SizedBox(height: 15),
        widget.isGoogleSignin
            ? const SizedBox()
            : CustomTextfieldWidget(
                hintText: "Email",
                size: size,
                controller: emailController,
              ),
        const SizedBox(height: 15),
        CustomTextfieldWidget(
          maxLines: 3,
          hintText: "Address",
          size: size,
          controller: addressController,
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle sign-up logic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: singUPButtonColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
