import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTileForReview extends StatelessWidget {
  const CustomTileForReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            "Reviews",
            style: GoogleFonts.inter(
              fontSize: 21.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
