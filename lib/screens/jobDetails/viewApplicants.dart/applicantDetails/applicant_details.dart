import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile.dart';
import 'package:lite_jobs/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile_for_recent.dart';
import 'package:lite_jobs/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile_for_review.dart';
import 'package:lite_jobs/screens/jobDescription/jJobHostdetailsPage/widgets/review_card.dart';

class ApplicantDetails extends StatelessWidget {
  const ApplicantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/person_2.jpeg")),
                color: const Color(0xFFBBE8EE),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const LineIcon.arrowCircleLeft(
                          size: 38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomListTile(
              name: "Ayushya",
            ),
            ListTile(
              title: Text(
                'Electronic engineer who is passionated about life ',
                style: GoogleFonts.inter(fontSize: 21),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
                height: 3,
              ),
            ),
            const CustomListTileForRecent(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
                height: 3,
              ),
            ),
            Stack(children: [
              const CustomTileForReview(),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: SizedBox(
                    height: 250,
                    child: AppinioSwiper(
                      cardsSpacing: 20,
                      backgroundCardsCount: 2,
                      loop: true,
                      cardsBuilder: (context, index) {
                        return const ReviewCard();
                      },
                      cardsCount: 5,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}
