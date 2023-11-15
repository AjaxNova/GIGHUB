import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color color;
  final Color borderColor;
  final double elevation;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.color,
    required this.borderColor,
    required this.elevation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: color,
          minimumSize: Size(size.width * 0.48, size.width * 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: BorderSide(color: borderColor)),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: GoogleFonts.inter(
            fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}
