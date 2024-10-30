import 'package:flutter/material.dart';
import 'package:lite_jobs/common/constants/constants.dart';

class CustomAuthTextField extends StatefulWidget {
  const CustomAuthTextField(
      {super.key,
      required this.controller,
      required this.iconType,
      required this.hintText,
      this.isPassword = false,
      this.isAddress = false});

  final TextEditingController controller;
  final IconType iconType;
  final bool isPassword;
  final String hintText;
  final bool isAddress;

  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool toggleEye = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: (fieldVal) => validateInput(fieldVal, widget.iconType),
        obscureText: widget.isPassword
            ? toggleEye
                ? true
                : false
            : false,
        decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        toggleEye = !toggleEye;
                      });
                    },
                    icon: Icon(
                      toggleEye
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: Colors.grey[500],
                    ),
                  )
                : const SizedBox(),
            prefixIcon: SizedBox(
              width: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getIconForType(widget.iconType),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    decoration: const BoxDecoration(
                        border: Border(right: BorderSide())),
                  )
                ],
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: authFieldOutlineInputBorder,
            focusedBorder: authFieldOutlineInputBorder,
            errorBorder: authFieldErrorOutlineInputBorder,
            focusedErrorBorder: authFieldErrorOutlineInputBorder),
      ),
    );
  }
}
