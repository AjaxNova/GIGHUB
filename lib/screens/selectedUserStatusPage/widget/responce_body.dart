import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../../../models/user_model.dart';
import '../../../utils/colors/colors.dart';

class ResponceBody extends StatelessWidget {
  const ResponceBody({super.key, required this.size, this.usser, this.job});

  final Size size;
  final JobModel? job;
  final UserModel? usser;
  final String defaultString = "JohnDoe";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.016),
        SizedBox(
            height: size.height * .36,
            child: job!.isCancelled
                ? SvgPicture.asset("assets/images/job_cancelled.svg")
                : job!.isAcceptedBySelectedUser
                    ? SvgPicture.asset("assets/images/5538959_2867043.svg")
                    : SvgPicture.asset("assets/images/5538959_2867043.svg")),
        Text(
          usser?.username ?? defaultString,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          "has confirmedv the offer",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: size.height * 0.045,
        ),
        SizedBox(
          // color: Colors.red,
          width: 342,
          child: Center(
            child: Text(
              "now you can chat with ${usser?.username ?? defaultString} in the chat screen . be polite and humble in the chat always remember give respect and take respect",
              style: GoogleFonts.inter(
                fontSize: 15.5,
                wordSpacing: .5,
                letterSpacing: .1,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.09,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 2,
              backgroundColor: Colors.white,
              minimumSize: const Size(182, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              side: BorderSide(color: Colors.grey.shade400)),
          onPressed: () {},
          child: Wrap(
            children: [
              Text(
                "Chat",
                style: GoogleFonts.inter(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const LineIcon.facebookMessenger(
                color: messengerIconColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
