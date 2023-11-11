import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VectorImage extends StatelessWidget {
  const VectorImage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size.height * .28,
          width: size.width * 0.75,
          child: SvgPicture.asset("assets/images/logIn.svg"),
        ),
        // Positioned(
        //   top: 20,
        //   left: 12,
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: const LineIcon.arrowCircleLeft(
        //       size: 44,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
