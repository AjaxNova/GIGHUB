import 'package:flutter/material.dart';
import 'package:lite_jobs/common/constants/constants.dart';
import 'package:lite_jobs/features/auth/presentation/widgets/custom_auth_textfield.dart';

class SignUpAuthSection extends StatelessWidget {
  const SignUpAuthSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.size,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.mobileController,
    required this.addressController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Size size;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [
          Card(
            color: Colors.white54,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white54)),
              // height: size.height * 0.60,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      CustomAuthTextField(
                          controller: nameController,
                          iconType: IconType.name,
                          hintText: 'UserName'),
                      CustomAuthTextField(
                          controller: emailController,
                          iconType: IconType.email,
                          hintText: 'Email'),
                      CustomAuthTextField(
                          controller: passwordController,
                          iconType: IconType.password,
                          isPassword: true,
                          hintText: 'Password'),
                      CustomAuthTextField(
                          controller: mobileController,
                          iconType: IconType.phone,
                          hintText: 'Phone Number'),
                      CustomAuthTextField(
                          isAddress: true,
                          controller: addressController,
                          iconType: IconType.address,
                          hintText: 'Address'),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
