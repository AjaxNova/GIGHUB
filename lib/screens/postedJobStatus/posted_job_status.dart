import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/provider/auth_provider.dart';
import 'package:lite_jobs/screens/jobDetails/viewApplicants.dart/view_applicants.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/special_appbar_widget.dart';
import '../../models/user_model.dart';
import '../../utils/colors/colors.dart';
import '../../utils/utils.dart';
import '../chatScreen/chat_screen.dart';

class CurrentJobResponcePagePosted extends StatelessWidget {
  const CurrentJobResponcePagePosted({
    super.key,
    required this.jobid,
  });

  final String jobid;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Jobs')
              .doc(jobid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                  jobSnapshot) {
            if (jobSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: Column(children: [CircularProgressIndicator()]),
                ),
              );
            } else {
              if (jobSnapshot.hasData) {
                final jobMod = JobModel.fromsnap(
                    jobSnapshot.data as DocumentSnapshot<Object?>);

                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(jobMod.selectedUser)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      if (jobMod.selectedUser == "not selected") {
                        return Scaffold(
                          appBar: SpecialAppbar(
                              context: context,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              appBarTitle: "status"),
                          bottomNavigationBar: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Utils().navigateMe(
                                    context: context,
                                    page: ViewApplicantsPage(jobid: jobid));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: test1,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "select a candidate",
                                  style: GoogleFonts.inter(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                          body: Column(
                            children: [
                              SizedBox(height: size.height * 0.046),
                              SizedBox(
                                  height: size.height * .31,
                                  child: SvgPicture.asset(
                                      "assets/images/not_selected_applicant_yet.svg")),
                              Text(
                                "you have'nt",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 29,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                "selected anyone yet",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 29,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.055,
                              ),
                              SizedBox(
                                width: size.width * 0.78,
                                child: Center(
                                  child: Text(
                                    "Sometimes people have trouble to reply soon feel free to wait or you could always change your prefrence anytime",
                                    style: GoogleFonts.inter(
                                      fontSize: 17.5,
                                      wordSpacing: .6,
                                      letterSpacing: .5,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }

                      final userMod = UserModel.fromSnap(
                          userSnapshot.data as DocumentSnapshot<Object?>);

                      return Scaffold(
                        bottomNavigationBar: SizedBox(
                          height: size.width * 0.20,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18, top: 10),
                                child: GestureDetector(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Jobs')
                                          .doc(jobid)
                                          .update({
                                        'selectedUser': "not selected",
                                        'jobStatus': "not selected",
                                        'selectedUserStatus': false,
                                      });
                                    },
                                    child: jobMod.isAcceptedBySelectedUser ==
                                                false &&
                                            jobMod.isRejectedBySelectedUser ==
                                                false &&
                                            jobMod.selectedUser !=
                                                "not selected"

                                        ///waitng for the selected person to either accept or reject the offer
                                        ? Container(
                                            width: double.infinity,
                                            height: size.width * 0.15,
                                            decoration: BoxDecoration(
                                                color: test1,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              "cancel selection",
                                              style: GoogleFonts.inter(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          )
                                        : jobMod.isRejectedBySelectedUser
                                            ? GestureDetector(
                                                onTap: () {
                                                  Utils().navigateMe(
                                                      context: context,
                                                      page: ViewApplicantsPage(
                                                          jobid: jobid));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: test1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "choose another user",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                              )
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Colors.white,
                                                    minimumSize: Size(
                                                        size.width * 0.6,
                                                        size.height * 0.08),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .grey.shade400)),
                                                onPressed: () async {
                                                  // final CommentModel coMod =
                                                  //     CommentModel(
                                                  //         message: "hi",
                                                  //         recieverId:
                                                  //             jobMod.selectedUser,
                                                  //         senderId: jobMod.postedBy,
                                                  //         sentTime: DateTime.now());
                                                  log("im herererererere");
                                                  // FirebaseFirestore.instance
                                                  //     .collection('chats')
                                                  //     .doc(jobMod.postedBy)
                                                  //     .collection('chaters')
                                                  //     .doc(jobMod.selectedUser)
                                                  //     .collection('messages')
                                                  //     .add({});

                                                  Utils().navigateMe(
                                                      context: context,
                                                      page: SinglechatPage(
                                                        senderUid: prov
                                                            .getUserModel.uid,
                                                        recieverUid:
                                                            jobMod.selectedUser,
                                                      ));
                                                },
                                                child: Wrap(
                                                  children: [
                                                    Text(
                                                      "Chat",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                    const LineIcon
                                                        .facebookMessenger(
                                                      color: messengerIconColor,
                                                    )
                                                  ],
                                                ),
                                              )),
                              )
                            ],
                          ),
                        ),
                        appBar: SpecialAppbar(
                            context: context,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            appBarTitle: "Status"),
                        body: Column(
                          children: [
                            SizedBox(height: size.height * 0.046),
                            SizedBox(
                                height: size.height * .31,
                                child: jobMod.jobStatus == "not selected"
                                    ? SvgPicture.asset(
                                        "assets/images/not_selected_applicant_yet.svg")
                                    : jobMod.jobStatus ==
                                            "rejectedBySelectedUser"
                                        ? SvgPicture.asset(
                                            "assets/images/rejected_by_selected_user.svg")
                                        : jobMod.isAcceptedBySelectedUser
                                            ? SvgPicture.asset(
                                                "assets/images/selected_person_has_confirmed.svg")
                                            : SvgPicture.asset(
                                                "assets/images/waiting_for_selected_applicant.svg")),
                            jobMod.jobStatus == "selected" &&
                                    jobMod.isAcceptedBySelectedUser == false &&
                                    jobMod.isAcceptedBySelectedUser == false
                                ? Text(
                                    "waiting for",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 29,
                                    ),
                                  )
                                : jobMod.isAcceptedBySelectedUser
                                    ? Text(
                                        "${userMod.username},has",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 29,
                                        ),
                                      )
                                    : Text(
                                        "${userMod.username},has",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 29,
                                        ),
                                      ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            jobMod.jobStatus == "selected" &&
                                    jobMod.isAcceptedBySelectedUser == false &&
                                    jobMod.isRejectedBySelectedUser == false
                                ? SizedBox(
                                    width: size.width * 0.75,
                                    child: Text(
                                      "${userMod.username} , to  confirm the offer",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 29,
                                      ),
                                    ),
                                  )
                                : jobMod.isAcceptedBySelectedUser
                                    ? Text(
                                        "accepted the offer",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 29,
                                        ),
                                      )
                                    : Text(
                                        "rejected the offer",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 29,
                                        ),
                                      ),
                            SizedBox(
                              height: size.height * 0.016,
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: size.width * 0.89,
                              child: Center(
                                  child: jobMod.isAcceptedBySelectedUser ==
                                              false &&
                                          jobMod.isRejectedBySelectedUser ==
                                              false
                                      ? Text(
                                          "Sometimes people have trouble to reply soon feel free to wait or you could always change your prefrence anytime",
                                          style: GoogleFonts.inter(
                                            fontSize: 15.5,
                                            wordSpacing: .5,
                                            letterSpacing: .1,
                                          ),
                                        )
                                      : jobMod.isAcceptedBySelectedUser
                                          ? Text(
                                              "now you can chat with ayush arun in the chat screen . pe polite and humble in the chat always remember give respect and take respect",
                                              style: GoogleFonts.inter(
                                                fontSize: 15.5,
                                                wordSpacing: .5,
                                                letterSpacing: .1,
                                              ),
                                            )
                                          : Text(
                                              "its ok sometimes people have some inconvenience , now you can pick from the other users",
                                              style: GoogleFonts.inter(
                                                fontSize: 15.5,
                                                wordSpacing: .5,
                                                letterSpacing: .1,
                                              ),
                                            )),
                            ),
                            SizedBox(
                              height: size.height * 0.09,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
          }),
    );
  }
}
