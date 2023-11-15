import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

class ConfirmedResponse extends StatelessWidget {
  const ConfirmedResponse({Key? key})
      : super(key: key); // Fixed the super constructor call.

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            SpecialAppbar(
              appBarTitle: "Confirmed",
              context: context,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: size.height * 0.016),
            SizedBox(
              height: size.height * .36,
              child: SvgPicture.asset("assets/images/5538959_2867043.svg"),
            ),
            Text(
              "Ayush Arun",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "has confirmed the offer",
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
                  "now you can chat with ayush arun in the chat screen . pe polite and humble in the chat always remember give respect and take respect",
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
        ),
      ),
    );
  }
}
