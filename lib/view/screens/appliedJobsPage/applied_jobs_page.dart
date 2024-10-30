// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
// import 'package:lite_jobs/provider/auth_provider.dart';
// import 'package:provider/provider.dart';

// import '../../models/user_model.dart';
// import '../mainJobScreen/widget/job_card_widget.dart';

// class AppliedJobsPage extends StatelessWidget {
//   const AppliedJobsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     log("im gere=-=-=----------------=-=====-");
//     final prov = Provider.of<AuthProvider>(context, listen: false);
//     final Size size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         appBar: SpecialAppbar(
//           appBarTitle: "applied jobs",
//           context: context,
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               prov.getUserModel.appliedJobs == []
//                   ? SizedBox(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: size.height * .5,
//                             child: SvgPicture.asset(
//                                 "assets/images/no_job_found_vector.svg"),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Text(
//                               "No jobs found",
//                               style: GoogleFonts.inter(
//                                   fontSize: 33, fontWeight: FontWeight.bold),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: prov.getUserModel.appliedJobs.length,
//                       itemBuilder: (context, index) {
//                         final data = prov.getUserModel.appliedJobs[index];
//                         return StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('Jobs')
//                               .where('jobId', isEqualTo: data)
//                               .snapshots(),
//                           builder: (context,
//                               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                                   snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                 child: Column(children: [
//                                   SizedBox(
//                                     height: size.height * 0.4,
//                                   ),
//                                   const CircularProgressIndicator()
//                                 ]),
//                               );
//                             } else {
//                               final jobThis =
//                                   JobModel.fromsnap(snapshot.data!.docs.first);
//                               return JobCardWidget(
//                                 job: jobThis,
//                                 isPosted: true,
//                               );
//                             }
//                           },
//                         );
//                       },
//                     )
//               // StreamBuilder(
//               //   stream: FirebaseFirestore.instance
//               //       .collection('users')
//               //       .where('uid', isEqualTo: prov.getUserModel.uid)
//               //       .snapshots(),
//               //   builder: (context,
//               //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//               //           snapshot) {
//               //     if (snapshot.connectionState == ConnectionState.waiting) {
//               //       return const CircularProgressIndicator();
//               //     } else {
//               //       if (snapshot.hasData) {
//               //         final userThis =
//               //             UserModel.fromSnap(snapshot.data!.docs[0]);
//               //         if (userThis.appliedJobs == []) {
//               //           return SizedBox(
//               //             child: Column(
//               //               children: [
//               //                 SizedBox(
//               //                   height: size.height * .5,
//               //                   child: SvgPicture.asset(
//               //                       "assets/images/no_job_found_vector.svg"),
//               //                 ),
//               //                 Padding(
//               //                   padding: const EdgeInsets.only(top: 10),
//               //                   child: Text(
//               //                     "No jobs found",
//               //                     style: GoogleFonts.inter(
//               //                         fontSize: 33,
//               //                         fontWeight: FontWeight.bold),
//               //                   ),
//               //                 )
//               //               ],
//               //             ),
//               //           );
//               //         } else {
//               //           log("++++++++++++++++applied:${userThis.appliedJobs}");
//               //           return ListView.builder(
//               //             shrinkWrap: true,
//               //             itemCount: 1,
//               //             itemBuilder: (context, index) {
//               //               log(userThis.appliedJobs[index]);
//               //               final data = userThis.appliedJobs[index];
//               //               return StreamBuilder(
//               //                 stream: FirebaseFirestore.instance
//               //                     .collection('Jobs')
//               //                     .where('JobId', isEqualTo: data)
//               //                     .snapshots(),
//               //                 builder: (context,
//               //                     AsyncSnapshot<
//               //                             QuerySnapshot<Map<String, dynamic>>>
//               //                         snapshot) {
//               //                   if (snapshot.connectionState ==
//               //                       ConnectionState.waiting) {
//               //                     return Center(
//               //                       child: Column(children: [
//               //                         SizedBox(
//               //                           height: size.height * 0.4,
//               //                         ),
//               //                         const CircularProgressIndicator()
//               //                       ]),
//               //                     );
//               //                   } else {
//               //                     final jobThis = JobModel.fromsnap(
//               //                         snapshot.data!.docs.first);
//               //                     return JobCardWidget(job: jobThis);
//               //                   }
//               //                 },
//               //               );
//               //             },
//               //           );
//               //         }
//               //       } else {
//               //         return const Center(child: Text("no data"));
//               //       }
//               //     }
//               //   },
//               // )
//             ],
//           ),
//         ),
//       ),
//     );

//     // final Size size = MediaQuery.of(context).size;

//     // return SafeArea(
//     //     child: Consumer<AuthProvider>(builder: (context, value, child) {
//     //   return Scaffold(
//     //       appBar:
//     // SpecialAppbar(
//     //         appBarTitle: "applied jobs",
//     //         context: context,
//     //         onTap: () {
//     //           Navigator.pop(context);
//     //         },
//     //       ),
//     //       body:
//     //(value.getUserModel.appledJobs as List<dynamic>).isEmpty
//     //           ? SizedBox(
//     //               child: Column(
//     //                 children: [
//     //                   SizedBox(
//     //                     height: size.height * .5,
//     //                     child: SvgPicture.asset(
//     //                         "assets/images/no_job_found_vector.svg"),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.only(top: 10),
//     //                     child: Text(
//     //                       "No jobs found",
//     //                       style: GoogleFonts.inter(
//     //                           fontSize: 33, fontWeight: FontWeight.bold),
//     //                     ),
//     //                   )
//     //                 ],
//     //               ),
//     //             )
//     //           : ListView.builder(
//     //               itemCount: value.getUserModel.appledJobs.length,
//     //               itemBuilder: (context, index) {
//     //                 final data = value.getUserModel.appledJobs[index];
//     //                 return StreamBuilder(
//     //                   stream: FirebaseFirestore.instance
//     //                       .collection('Jobs')
//     //                       .doc(data)
//     //                       .snapshots(),
//     //                   builder: (context, snapshot) {
//     //                     if (snapshot.connectionState ==
//     //                         ConnectionState.waiting) {
//     //                       return const CircularProgressIndicator();
//     //                     } else {
//     //                       final jobThis = JobModel.fromsnap(
//     //                           snapshot.data as DocumentSnapshot<Object?>);
//     //                       return JobCardWidget(job: jobThis);
//     //                     }
//     //                   },
//     //                 );
//     //               },
//     //             )
//     //       // StreamBuilder(
//     //       //     stream: FirebaseFirestore.instance
//     //       //         .collection("Jobs")
//     //       //         .where('jobId', isEqualTo: prov.getUserModel.uid)
//     //       //         .snapshots(),
//     //       //     builder: (context,
//     //       //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//     //       //             snapshot) {
//     //       //       if (snapshot.connectionState == ConnectionState.waiting) {
//     //       //         return const Center(child: CircularProgressIndicator());
//     //       //       } else {
//     //       //         if (snapshot.hasData) {
//     //       //           if (snapshot.data!.docs.isEmpty) {
//     //       //             return SizedBox(
//     //       //               child: Column(
//     //       //                 children: [
//     //       //                   SizedBox(
//     //       //                     height: size.height * .5,
//     //       //                     child: SvgPicture.asset(
//     //       //                         "assets/images/no_job_found_vector.svg"),
//     //       //                   ),
//     //       //                   Padding(
//     //       //                     padding: const EdgeInsets.only(top: 10),
//     //       //                     child: Text(
//     //       //                       "No jobs found",
//     //       //                       style: GoogleFonts.inter(
//     //       //                           fontSize: 33,
//     //       //                           fontWeight: FontWeight.bold),
//     //       //                     ),
//     //       //                   )
//     //       //                 ],
//     //       //               ),
//     //       //             );
//     //       //           }
//     //       //           return Expanded(
//     //       //               child: ListView.builder(
//     //       //             itemCount: snapshot.data!.docs.length,
//     //       //             itemBuilder: (context, index) {
//     //       //               final job =
//     //       //                   JobModel.fromsnap(snapshot.data!.docs[index]);

//     //       //               return JobCardWidget(
//     //       //                 job: job,
//     //       //                 isPosted: true,
//     //       //               );
//     //       //             },
//     //       //           ));
//     //       //         } else {
//     //       //           return const CircularProgressIndicator();
//     //       //         }
//     //       //       }
//     //       //     },
//     //       //   ),
//     //       );
//     // }
//     // )
//     // );
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/widget/job_card_widget.dart';
// import 'package:lite_jobs/screens/mainJobScreen/widget/job_card_widget.dart';
import 'package:provider/provider.dart';

class AppliedJobsPage extends StatelessWidget {
  const AppliedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProviderData>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
            appBarTitle: "Applied Jobs"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.getUserModel.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                  userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final userMod = UserModel.fromSnap(
                  userSnapshot.data as DocumentSnapshot<Object?>);
              if (userMod.appliedJobs.isEmpty) {
                return SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .5,
                        child: SvgPicture.asset(
                            "assets/images/no_job_found_vector.svg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "No jobs found",
                          style: GoogleFonts.inter(
                              fontSize: 33, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: userMod.appliedJobs.length,
                      itemBuilder: (context, index) {
                        final jobid = userMod.appliedJobs[index];
                        log('$jobid this is the job id =====================???????????dafsjadfhjksdfhksdffffffffffffffffffffffffffffffffffffffffffff');
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Jobs')
                              .doc(jobid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  jobSnapshot) {
                            if (jobSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            } else {
                              final jobMod = JobModel.fromsnap(jobSnapshot.data
                                  as DocumentSnapshot<Object?>);

                              return JobCardWidget(
                                job: jobMod,
                                isApplied: true,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
