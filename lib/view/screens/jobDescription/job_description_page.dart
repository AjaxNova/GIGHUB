import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_stack/image_stack.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/common/widgets/requirements_text_widget.dart';
import 'package:lite_jobs/controller/provider/job_description_page_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/screens/jobDetails/viewApplicants.dart/view_applicants.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/auth_provider.dart';
import '../../utils/colors/colors.dart';
import '../appliedJobStatus/applied_job_status.dart';
import '../auth/widget/custom_button.dart';
import '../postedJobStatus/posted_job_status.dart';
import '../profilePage/profile_page.dart';

class JobDescriptionPage extends StatelessWidget {
  final JobModel job;
  final bool isPosted;
  const JobDescriptionPage(
      {super.key, required this.job, this.isPosted = false});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Consumer<JobDescriptionProvider>(
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
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
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
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    job.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                width: double.infinity,
                                height: 225,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(job.photoUrl))),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              job.description,
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              'Date: ${value.extractMonthDay(job.date.toString())}',
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                job.time,
                                style: GoogleFonts.inter(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Container(
                        //*//
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBE8EE),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Requirements',
                              style: GoogleFonts.inter(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: job.requirements.length,
                                itemBuilder: (context, index) {
                                  final data = job.requirements[index];
                                  return RequirementTexts(content: data);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isPosted
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Jobs')
                                  .doc(job.jobId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  final jobMod = JobModel.fromsnap(snapshot.data
                                      as DocumentSnapshot<Object?>);
                                  if (jobMod.appliedUsers.length == 0) {
                                    return viewApplicant(context, jobMod, 0);
                                  } else if (jobMod.appliedUsers.length == 1) {
                                    return _viewApplicants(
                                        MediaQuery.of(context).size,
                                        jobMod.jobId,
                                        context);
                                  } else if (jobMod.appliedUsers.length == 2) {
                                    return _viewApplicants(
                                        MediaQuery.of(context).size,
                                        jobMod.jobId,
                                        context);
                                  } else {
                                    return _viewApplicants(
                                        MediaQuery.of(context).size,
                                        jobMod.jobId,
                                        context);
                                  }
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            )

                          // Container(
                          //     height: 60,
                          //     //padding: const EdgeInsets.all(5),
                          //     decoration: BoxDecoration(
                          //       color: const Color(0xFF8CD2DB),
                          //       borderRadius: BorderRadius.circular(12.0),
                          //     ),
                          //     child: ListTile(
                          //       onTap: () {
                          //         Utils().navigateMe(
                          //             context: context,
                          //             page: ViewApplicantsPage(
                          //               jobid: job.jobId,
                          //             ));
                          //       },
                          //       title: Text('View Applicants',
                          //           style: GoogleFonts.inter(
                          //             fontSize: 18.0,
                          //             fontWeight: FontWeight.w500,
                          //           )),
                          //       trailing: Wrap(
                          //         children: [
                          //           const SizedBox(
                          //             width: 80,
                          //             child: Stack(
                          //               alignment: Alignment.center,
                          //               children: [
                          //                 CircleAvatar(
                          //                   backgroundColor: Color(0xFFF54A4A),
                          //                   radius: 18.0,
                          //                   child: Icon(Icons.person),
                          //                 ),
                          //                 Positioned(
                          //                   left: 33.0,
                          //                   child: CircleAvatar(
                          //                     backgroundColor:
                          //                         Color(0xFF0469FF),
                          //                     radius: 18.0,
                          //                     child: Icon(Icons.person),
                          //                   ),
                          //                 ),
                          //                 Positioned(
                          //                   left: 45.0,
                          //                   child: CircleAvatar(
                          //                     backgroundColor:
                          //                         Color(0xFF0AFF22),
                          //                     radius: 18.0,
                          //                     child: Icon(Icons.person),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: const EdgeInsets.only(
                          //                 top: 5, left: 5),
                          //             child: const Icon(
                          //               Icons.arrow_forward_ios,
                          //               color: Colors.grey,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Job Posted by:",
                                  style: GoogleFonts.inter(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('uid', isEqualTo: job.postedBy)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return const Text('User data not found');
                                    }

                                    final userModel = UserModel.fromSnap(
                                        snapshot.data!.docs[0]);

                                    return Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8CD2DB),
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Utils().navigateMe(
                                              context: context,
                                              page: ProfilePage(
                                                user: userModel,
                                              ));
                                        },
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userModel.photoUrl),
                                        ),
                                        title: Text(
                                          userModel.username,
                                          style: GoogleFonts.inter(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                      const SizedBox(
                        height: 20,
                      ),
                      isPosted
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Jobs')
                                  .where('jobId', isEqualTo: job.jobId)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasData) {
                                    // final prov = Provider.of<AuthProvider>(
                                    //     context,
                                    //     listen: false);
                                    // final jobSelected = JobModel.fromsnap(
                                    //     snapshot.data!.docs[0]);
                                    return Row(
                                      children: [
                                        CustomButton(
                                          buttonText: "Cancel",
                                          color: const Color(0xFFE98A84),
                                          borderColor: Colors.grey,
                                          elevation: 0,
                                          onTap: () async {
                                            value.changeLoading();
                                            final val =
                                                await value.cancelPostedjob(
                                                    job.jobId, context);
                                            value.changeLoading();
                                            Utils().showSnackBarMessage(
                                                context: context, content: val);

                                            if (val == "job cancelled") {
                                              Navigator.of(context).pop();
                                            }

                                            // value.changeLoading();
                                            // final res = await value
                                            //     .cancelJobApplication(
                                            //         job.jobId, context);
                                            // value.changeLoading();

                                            // Utils().showSnackBarMessage(
                                            //     context: context, content: res);
                                          },
                                        ),
                                        Expanded(
                                          child: CustomButton(
                                              buttonText: "check Status",
                                              color: a,
                                              borderColor: Colors.grey,
                                              elevation: 0,
                                              onTap: () {
                                                Utils().navigateMe(
                                                    context: context,
                                                    page:
                                                        CurrentJobResponcePagePosted(
                                                            jobid: job.jobId));
                                                // value.changeLoading();
                                                // final res =
                                                //     await value.applyForJob(
                                                //         job.jobId, context);
                                                // value.changeLoading();
                                                // Utils().showSnackBarMessage(
                                                //     context: context,
                                                //     content: res);
                                              }),
                                        )
                                      ],
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }
                              },
                            )
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Jobs')
                                  .where('jobId', isEqualTo: job.jobId)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasData) {
                                    final prov = Provider.of<AuthProvider>(
                                        context,
                                        listen: false);
                                    final jobSelected = JobModel.fromsnap(
                                        snapshot.data!.docs[0]);
                                    return jobSelected.appliedUsers
                                            .contains(prov.getUserModel.uid)
                                        ? Row(
                                            children: [
                                              CustomButton(
                                                buttonText: "Cancel",
                                                color: const Color(0xFFE98A84),
                                                borderColor: Colors.grey,
                                                elevation: 0,
                                                onTap: () async {
                                                  value.changeLoading();
                                                  final res = await value
                                                      .cancelJobApplication(
                                                          job.jobId, context);
                                                  value.changeLoading();

                                                  Utils().showSnackBarMessage(
                                                      context: context,
                                                      content: res);
                                                },
                                              ),
                                              Expanded(
                                                child: CustomButton(
                                                    buttonText: "check Status",
                                                    color: a,
                                                    borderColor: Colors.grey,
                                                    elevation: 0,
                                                    onTap: () {
                                                      Utils().navigateMe(
                                                          context: context,
                                                          page:
                                                              CurrentJobResponcePageApplied(
                                                                  jobid: job
                                                                      .jobId));
                                                      // value.changeLoading();
                                                      // final res =
                                                      //     await value.applyForJob(
                                                      //         job.jobId, context);
                                                      // value.changeLoading();
                                                      // Utils().showSnackBarMessage(
                                                      //     context: context,
                                                      //     content: res);
                                                    }),
                                              )
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              CustomButton(
                                                buttonText:
                                                    "already applied:${jobSelected.appliedUsers!.length}",
                                                color: const Color(0xFFE98A84),
                                                borderColor: Colors.grey,
                                                elevation: 0,
                                                onTap: () async {
                                                  // final res = await applyForJob(
                                                  //     job.jobId, context);
                                                  // Utils().showSnackBarMessage(
                                                  //     context: context, content: res);
                                                },
                                              ),
                                              Expanded(
                                                child: CustomButton(
                                                    buttonText: "apply",
                                                    color:
                                                        const Color(0xFF84E9B8),
                                                    borderColor: Colors.grey,
                                                    elevation: 0,
                                                    onTap: () async {
                                                      value.changeLoading();
                                                      final res = await value
                                                          .applyForJob(
                                                              job.jobId,
                                                              context);
                                                      value.changeLoading();
                                                      Utils()
                                                          .showSnackBarMessage(
                                                              context: context,
                                                              content: res);
                                                    }),
                                              )
                                            ],
                                          );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                      // Row(
                      //   children: [
                      //     StreamBuilder(
                      //       stream: FirebaseFirestore.instance
                      //           .collection('Jobs')
                      //           .where('jobId', isEqualTo: job.jobId)
                      //           .snapshots(),
                      //       builder: (context,
                      //           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      //               snapshot) {
                      //         if (snapshot.connectionState ==
                      //             ConnectionState.waiting) {
                      //           return CustomButton(
                      //               buttonText: "already applied: -- ",
                      //               color: const Color(0xFFE98A84),
                      //               borderColor: Colors.grey,
                      //               elevation: 0,
                      //               onTap: () {});
                      //         } else {
                      //           if (snapshot.hasData) {
                      //             final prov = Provider.of<AuthProvider>(context,
                      //                 listen: false);
                      //             final jobSelected =
                      //                 JobModel.fromsnap(snapshot.data!.docs[0]);
                      //             // if (jobSelected.appliedUsers
                      //             //     .contians(prov.getUserModel.uid)) {
                      //             //   return CustomButton(
                      //             //       buttonText: "buttonText",
                      //             //       color: test1,
                      //             //       borderColor: test3,
                      //             //       elevation: 3,
                      //             //       onTap: () {});
                      //             // } else {
                      //             return CustomButton(
                      //                 buttonText:
                      //                     "already applied:${jobSelected.appliedUsers!.length}",
                      //                 color: const Color(0xFFE98A84),
                      //                 borderColor: Colors.grey,
                      //                 elevation: 0,
                      //                 onTap: () async {
                      //                   final res =
                      //                       await applyForJob(job.jobId, context);
                      //                   Utils().showSnackBarMessage(
                      //                       context: context, content: res);
                      //                 });
                      //           } else {
                      //             return CustomButton(
                      //                 buttonText: "already applied: -- ",
                      //                 color: const Color(0xFFE98A84),
                      //                 borderColor: Colors.grey,
                      //                 elevation: 0,
                      //                 onTap: () {});
                      //           }
                      //         }
                      //       },
                      //     ),
                      //     Expanded(
                      //       child: CustomButton(
                      //           buttonText: "apply",
                      //           color: const Color(0xFF84E9B8),
                      //           borderColor: Colors.grey,
                      //           elevation: 0,
                      //           onTap: () {}),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Container viewApplicant(BuildContext context, JobModel job, int option) {
  return Container(
    height: 60,
    //padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: const Color(0xFF8CD2DB),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: ListTile(
      onTap: () {
        Utils().navigateMe(
            context: context,
            page: ViewApplicantsPage(
              jobid: job.jobId,
            ));
      },
      title: Text('View Applicants',
          style: GoogleFonts.inter(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          )),
      trailing: Wrap(
        children: [
          option == 0
              ? const SizedBox()
              : Container(
                  color: Colors.red,
                  width: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFF54A4A),
                        radius: 18.0,
                        child: Icon(Icons.person),
                      ),
                      option == 2 || option == 3
                          ? const Positioned(
                              left: 37.0,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF0469FF),
                                radius: 18.0,
                                child: Icon(Icons.person),
                              ),
                            )
                          : const SizedBox(),
                      option == 3
                          ? const Positioned(
                              left: 52.0,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF0AFF22),
                                radius: 18.0,
                                child: Icon(Icons.person),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(top: 5, left: 5),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

_viewApplicants(Size size, String jobId, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Utils()
          .navigateMe(context: context, page: ViewApplicantsPage(jobid: jobId));
    },
    child: Column(
      children: [
        Card(
          child: Container(
            height: size.height * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF8CD2DB)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('View Applicants',
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Jobs')
                        .doc(jobId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshot.hasData) {
                          final data = JobModel.fromsnap(
                              snapshot.data as DocumentSnapshot<Object?>);
                          if (data.appliedUsers.length == 0) {
                            return const SizedBox();
                          } else {
                            return FutureBuilder(
                              future: fetchUserData(data.appliedUsers),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ImageStack(
                                      imageBorderWidth: 0,
                                      imageRadius: 39,
                                      imageList: snapshot.data!,
                                      totalCount:
                                          snapshot.data!.length > 3 ? 3 : 0);
                                }
                              },
                            );
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

_applicantAvatar() {
  return const CircleAvatar(
    backgroundColor: Color(0xFFF54A4A),
    radius: 18.0,
    child: Icon(Icons.person),
  );
}

Future<List<String>> fetchUserData(List<dynamic> appliedUsers) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> usersPics = [];

  for (String userId in appliedUsers) {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      final data = userSnapshot['photoUrl'];
      usersPics.add(data);
    } else {
      print('User with ID $userId not found.');
    }
  }

  return usersPics;
}
