import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  // final VoidCallback onFavoritePressed;

  const CustomListTile({
    super.key,
    required this.name,
    //   required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        name,
        style: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      // trailing: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Text(
      //       '$likes',
      //       style: const TextStyle(
      //         fontSize: 18.0,
      //         color: Colors.grey,
      //       ),
      //     ),
      //     IconButton(
      //       icon: const Icon(
      //         Icons.favorite_outline,
      //         color: Colors.red,
      //         size: 30.0,
      //       ),
      //       onPressed: onFavoritePressed,
      //     ),
      //   ],
      // ),
    );
  }
}
