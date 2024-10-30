import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/controller/provider/job_description_page_provider.dart';
import 'package:lite_jobs/controller/provider/select_person_from_applied_list.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/editProfilePage/edit_profile_page.dart';
import 'package:lite_jobs/view/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile.dart';
import 'package:lite_jobs/view/screens/jobDescription/jJobHostdetailsPage/widgets/custom_listtile_for_recent.dart';
import 'package:provider/provider.dart';

import '../jobDetails/job_details_host.dart';
import '../mainJobScreen/main_screen.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  final bool isHost;
  final bool isApplicant;
  final String? jobId;
  const ProfilePage(
      {super.key,
      required this.user,
      this.isHost = false,
      this.isApplicant = false,
      this.jobId});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return fullPage(context, user);
                  } else {
                    if (snapshot.hasData) {
                      final userMod = UserModel.fromSnap(
                          snapshot.data as DocumentSnapshot<Object?>);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.36,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(userMod.photoUrl)),
                                color: const Color(0xFFBBE8EE),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Card(
                                          shadowColor: Colors.white,
                                          elevation: 40,
                                          child: LineIcon.arrowCircleLeft(
                                            size: 35,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      isHost
                                          ? InkWell(
                                              onTap: () {
                                                Utils().navigateMe(
                                                    context: context,
                                                    page: EditProfilePage(
                                                        userModel: userMod));
                                              },
                                              child: const Card(
                                                color: Colors.white,
                                                elevation: 5,
                                                child: LineIcon.edit(
                                                  size: 33,
                                                ),
                                              ))
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomListTile(
                            name: userMod.username,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text(
                              userMod.bio ?? 'bio',
                              style: GoogleFonts.inter(fontSize: 17),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Age:',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  userMod.age,
                                  style: GoogleFonts.inter(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Gender:',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      userMod.gender,
                                      style: GoogleFonts.inter(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    userMod.gender == "Male"
                                        ? const Icon(Icons.male)
                                        : const Icon(Icons.female)
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //*//
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBBE8EE),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Skills',
                                    style: GoogleFonts.inter(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  SizedBox(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: userMod.skills.length,
                                      itemBuilder: (context, index) {
                                        final data = userMod.skills[index];
                                        return RequirementTexts(content: data);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //*//
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBBE8EE),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Highest Education Qualification',
                                    style: GoogleFonts.inter(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  SizedBox(
                                      child: RequirementTexts(
                                          content: userMod.highestQual))
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              height: 3,
                            ),
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: Text(
                                  "Recently Hosted Jobs",
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
                              userMod.postedJobs.length == 0
                                  ? const Text("No Job yet")
                                  : SizedBox(
                                      height: 70,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: userMod.postedJobs.length,
                                        itemBuilder: (context, index) {
                                          final job = userMod.postedJobs[index];
                                          return StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('Jobs')
                                                .doc(job)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        DocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const SizedBox();
                                              } else {
                                                if (snapshot.hasData) {
                                                  final prov = Provider.of<
                                                          JobDescriptionProvider>(
                                                      context,
                                                      listen: false);
                                                  final jobMod =
                                                      JobModel.fromsnap(snapshot
                                                              .data
                                                          as DocumentSnapshot<
                                                              Object?>);
                                                  String jobTitle =
                                                      jobMod.title;

                                                  return Container(
                                                    width: 350,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Card(
                                                      color: const Color(
                                                          0xFF84E9B8),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              jobTitle,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              ' ${prov.extractMonthDay(jobMod.date.toString())}',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                              height: 3,
                            ),
                          ),
                          // Stack(children: [
                          //   const CustomTileForReview(),
                          //   Positioned(
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 22),
                          //       child: SizedBox(
                          //         height: 250,
                          //         child: AppinioSwiper(
                          //           cardsSpacing: 20,
                          //           backgroundCardsCount: 2,
                          //           loop: true,
                          //           cardsBuilder: (context, index) {
                          //             return const ReviewCard();
                          //           },
                          //           cardsCount: 5,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ]),
                        ],
                      );
                    } else {
                      return fullPage(context, user);
                    }
                  }
                },
              )),
            ),
          ),
        );
      },
    );
  }
}

Column fullPage(BuildContext context, UserModel user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 220,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(user.photoUrl)),
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
      // Stack(children: [
      //   const CustomTileForReview(),
      //   Positioned(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 22),
      //       child: SizedBox(
      //         height: 250,
      //         child: AppinioSwiper(
      //           cardsSpacing: 20,
      //           backgroundCardsCount: 2,
      //           loop: true,
      //           cardsBuilder: (context, index) {
      //             return const ReviewCard();
      //           },
      //           cardsCount: 5,
      //         ),
      //       ),
      //     ),
      //   ),
      // ]),
    ],
  );
}
