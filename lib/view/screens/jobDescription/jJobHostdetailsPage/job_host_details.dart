import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/controller/provider/select_person_from_applied_list.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile.dart';
import 'package:lite_jobs/view/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile_for_recent.dart';
import 'package:lite_jobs/view/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile_for_review.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/main_screen.dart';
import 'package:provider/provider.dart';

class JobHostDetailsPage extends StatelessWidget {
  final UserModel user;
  final JobModel? job;
  final bool isApplicant;
  final String? jobId;
  const JobHostDetailsPage(
      {super.key,
      required this.user,
      this.isApplicant = false,
      this.jobId,
      this.job});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectPersonFromListProvider>(
      builder: (context, value, child) {
        return BlurryModalProgressHUD(
          inAsyncCall: value.isLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitWave(
            color: singInButtonColor,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black,
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: isApplicant
                  ? SizedBox(
                      height: 70,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18, top: 10),
                            child: GestureDetector(
                              onTap: () async {
                                log("selelct");
                                value.changeIsLoading();
                                final String val =
                                    await value.selectPersonForJobs(
                                  uid: user.uid,
                                  jobId: jobId,
                                );
                                value.changeIsLoading();
                                Utils().showSnackBarMessage(
                                    context: context, content: val);

                                if (val == "Applicant Selected") {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (route) => false,
                                  );
                                  // Utils().navigateMe(
                                  //     context: context,
                                  //     page: ResponcePage(
                                  //       selectedUser: user.uid,
                                  //       jobId: jobId!,
                                  //     ));
                                  // Utils().navigateMe(
                                  //     context: context,
                                  //     page: CurrentJobResponcePage(job: job!));
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: test1,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Select",
                                  style: GoogleFonts.inter(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 220,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(user.photoUrl)),
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
                    ),
                    CustomListTile(
                      name: user.username,
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
                    const Stack(children: [
                      CustomTileForReview(),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 22),
                          child: SizedBox(height: 250, child: SizedBox()
                              // AppinioSwiper(
                              //   cardsSpacing: 20,
                              //   backgroundCardsCount: 2,
                              //   loop: true,
                              //   cardsBuilder: (context, index) {
                              //     return const ReviewCard();
                              //   },
                              //   cardsCount: 5,
                              // ),
                              ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
