import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequirementTexts extends StatelessWidget {
  final String content;
  const RequirementTexts({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• $content',
          style: GoogleFonts.inter(
            height: 1.5,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
