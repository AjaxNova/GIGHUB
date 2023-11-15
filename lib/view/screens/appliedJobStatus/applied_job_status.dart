import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/screens/chatScreen/chat_screen.dart';
import 'package:lite_jobs/screens/mainJobScreen/main_screen.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/special_appbar_widget.dart';
import '../../controller/provider/auth_provider.dart';
import '../../utils/colors/colors.dart';

class CurrentJobResponcePageApplied extends StatefulWidget {
  const CurrentJobResponcePageApplied({super.key, required this.jobid});

  final String jobid;

  @override
  State<CurrentJobResponcePageApplied> createState() =>
      _CurrentJobResponcePageAppliedState();
}

class _CurrentJobResponcePageAppliedState
    extends State<CurrentJobResponcePageApplied> {
  bool val = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
            appBarTitle: "status"),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Jobs')
                .doc(widget.jobid)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    jobSnapshot) {
              if (jobSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(prov.getUserModel.uid)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final userMod = UserModel.fromSnap(
                          userSnapshot.data as DocumentSnapshot<Object?>);
                      final jobModel = JobModel.fromsnap(
                          jobSnapshot.data as DocumentSnapshot<Object?>);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.025),
                          SizedBox(
                              height: size.height * .37,
                              child: jobModel.jobStatus == "not selected"
                                  ? SvgPicture.asset(
                                      "assets/images/posted_person_not_pick_applicant_yet.svg")
                                  : jobModel.selectedUser == userMod.uid &&
                                          jobModel.isRejectedBySelectedUser
                                      ? SvgPicture.asset(
                                          "assets/images/rejected_by_selected_user.svg")
                                      : jobModel.jobStatus == "selected" &&
                                              jobModel.selectedUser ==
                                                  userMod.uid
                                          ? SvgPicture.asset(
                                              "assets/images/applied_person_selected.svg")
                                          : SvgPicture.asset(
                                              "assets/images/posted_person_picked_an_applicant_not_current_user.svg")),
                          jobModel.jobStatus == "not selected"
                              ? Text(
                                  "The employer ,",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                )
                              : jobModel.jobStatus == "selected" &&
                                      jobModel.selectedUser == userMod.uid
                                  ? Text(
                                      "you have,",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    )
                                  : jobModel.selectedUser == userMod.uid &&
                                          jobModel.isRejectedBySelectedUser
                                      ? Text(
                                          "you have,",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        )
                                      : Text(
                                          "sorry you ,",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          jobModel.jobStatus == "not selected"
                              ? SizedBox(
                                  width: size.width * 0.8,
                                  child: Center(
                                    child: Text(
                                      "have not selected anyone yet",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                )
                              : jobModel.jobStatus == "selected" &&
                                      jobModel.selectedUser == userMod.uid
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "been selected ",
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : jobModel.selectedUser == userMod.uid &&
                                          jobModel.isRejectedBySelectedUser
                                      ? Text(
                                          "rejected the offer",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        )
                                      : Text(
                                          "are not selected",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        ),
                          // Text(
                          //   "been selected for this job",
                          //   style: GoogleFonts.inter(
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 25,
                          //   ),
                          // ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          SizedBox(
                            // color: Colors.red,
                            width: size.width * 0.85,
                            child: Center(
                              child: jobModel.jobStatus == "not selected"
                                  ? Text(
                                      "The employer didnt select anyone yet , be patient and wait for the employer to make a decision",
                                      style: GoogleFonts.inter(
                                        fontSize: 15.5,
                                        wordSpacing: .5,
                                        letterSpacing: .1,
                                      ),
                                    )
                                  : jobModel.jobStatus == "selected" &&
                                          jobModel.selectedUser == userMod.uid
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "you have been selected by the employer now you can chat with him in the chat section , remember alwasy be polite , give respect and take respect",
                                            style: GoogleFonts.inter(
                                              fontSize: 15.5,
                                              wordSpacing: .5,
                                              letterSpacing: .1,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "The employer has selected someone else , its ok there are plenty of other jobs waiting for you be patient",
                                          style: GoogleFonts.inter(
                                            fontSize: 15.5,
                                            wordSpacing: .5,
                                            letterSpacing: .1,
                                          ),
                                        ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          jobModel.isAcceptedBySelectedUser &&
                                  jobModel.selectedUser == userMod.uid
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      backgroundColor: Colors.white,
                                      minimumSize: Size(
                                          size.width * 0.6, size.height * 0.08),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      side: BorderSide(
                                          color: Colors.grey.shade400)),
                                  onPressed: () {
                                    Utils().navigateMe(
                                        context: context,
                                        page: SinglechatPage(
                                          recieverUid: jobModel.postedBy,
                                          senderUid: userMod.uid,
                                        ));
                                  },
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
                              : jobModel.jobStatus == "selected" &&
                                      jobModel.selectedUser == userMod.uid
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              backgroundColor: Colors.red,
                                              minimumSize: Size(
                                                  size.width / 2.2,
                                                  size.height * 0.08),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.grey.shade400)),
                                          onPressed: () async {
                                            setState(() {
                                              val = true;
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('Jobs')
                                                .doc(jobModel.jobId)
                                                .update({
                                              "isRejectedBySelectedUser": true,
                                              "jobStatus":
                                                  "rejectedBySelectedUser",
                                              'rejectedUserList':
                                                  FieldValue.arrayUnion(
                                                      [jobModel.selectedUser]),
                                            });
                                            setState(() {
                                              val = false;
                                            });
                                          },
                                          child: Wrap(
                                            children: [
                                              val
                                                  ? const CircularProgressIndicator()
                                                  : const SizedBox(),
                                              Text(
                                                "cancel",
                                                style: GoogleFonts.inter(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const LineIcon.stopCircle(
                                                color: messengerIconColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              backgroundColor: Colors.green,
                                              minimumSize: Size(
                                                  size.width / 2.2,
                                                  size.height * 0.08),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.grey.shade400)),
                                          onPressed: () async {
                                            setState(() {
                                              val = true;
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('Jobs')
                                                .doc(jobModel.jobId)
                                                .update({
                                              'isAcceptedBySelectedUser': true,
                                            });

                                            setState(() {
                                              val = false;
                                            });
                                          },
                                          child: Wrap(
                                            children: [
                                              val
                                                  ? const CircularProgressIndicator()
                                                  : Text(
                                                      "Accept",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                              const LineIcon.facebookMessenger(
                                                color: messengerIconColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 2,
                                          backgroundColor: Colors.white,
                                          minimumSize: const Size(182, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          side: BorderSide(
                                              color: Colors.grey.shade400)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "Go to HomeScreen",
                                            style: GoogleFonts.inter(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
