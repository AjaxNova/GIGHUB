import 'package:flutter/material.dart';

import '../../widget/custom_textfield.dart';

Column textFieldArea(
    {required bool isGoogle,
    required Size size,
    required TextEditingController nameController,
    passwordController,
    addressController,
    mobileController,
    emailController}) {
  return Column(
    children: [
      CustomTextfieldWidget(
        hintText: "name",
        size: size,
        controller: nameController,
      ),
      CustomTextfieldWidget(
          hintText: "password",
          size: size,
          controller: passwordController,
          obscure: true),
      CustomTextfieldWidget(
        hintText: "phone number",
        size: size,
        controller: mobileController,
      ),
      isGoogle
          ? const SizedBox()
          : CustomTextfieldWidget(
              hintText: "email",
              size: size,
              controller: emailController,
            ),
      SizedBox(
        height: 100,
        child: CustomTextfieldWidget(
          maxLines: 3,
          hintText: "Address",
          size: size,
          controller: addressController,
        ),
      ),
    ],
  );
}
