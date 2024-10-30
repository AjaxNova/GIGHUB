import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lite_jobs/common/constants/constants.dart';

class VectorImage extends StatelessWidget {
  const VectorImage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white10,
              screenBackgroundColor,
            ]),
      ),
      child: SvgPicture.asset(
        "assets/images/logIn.svg",
        height: size.height * 20,
      ),
    );
  }
}
