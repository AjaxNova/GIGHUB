import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/controller/provider/home_screen_provider.dart';
import 'package:lite_jobs/core/res/user_model.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/widget/custom_drawer_widget.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/widget/job_card_widget.dart';
import 'package:lite_jobs/view/screens/postJobs/post_job.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userModelGlobal});

  final UserModelGlobal userModelGlobal;

  @override
  Widget build(BuildContext context) {
    UserModelGlobal user = userModelGlobal;
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Utils().navigateMe(context: context, page: const PostJobPage());
          },
          child: const FaIcon(FontAwesomeIcons.plus),
        ),
        drawer: const CustomDrawerWidget(),
        // appBar: const CustomAppBar(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<HomeScreenProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            "Welcome,",
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          final userMod = UserModel.fromSnap(
                              snapshot.data as DocumentSnapshot<Object?>);
                          return Text(
                            "Welcome, ${userMod.username}",
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                    Expanded(
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Jobs")
                          .orderBy(value.sortBy, descending: value.descending)
                          .snapshots(),
                      // stream: FirebaseFirestore.instance
                      //     .collection('Jobs')
                      //     .where('isCancelled', isEqualTo: false)
                      //     .where('postedBy', isNotEqualTo: user.uid)
                      //     .orderBy('postedBy', descending: false)
                      //     .orderBy('postedTime', descending: true)
                      //     .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return _hasNoJobsAvailableMethod(size);
                          }
                          // final prov =
                          //     Provider.of<HomeScreenProvider>(context, listen: false);
                          //   prov.

                          return _hasJobsAvailable(user, snapshot, context);
                        } else {
                          return _hasNoJobsAvailableMethod(size);
                        }
                      },
                    )),
                  ],
                );
              },
            )),
      ),
    );
  }

  Column _hasJobsAvailable(
      final UserModelGlobal userModelGlobal,
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<JobModel> jobList =
        snapshot.data!.docs.map((doc) => JobModel.fromsnap(doc)).toList();
    // jobList.removeWhere((job) => job.postedBy == prov.getUserModel.uid);
    jobList.removeWhere(
        (job) => job.postedBy == userModelGlobal.uid || job.isCancelled);
    // final prov = Provider.of<HomeScreenProvider>(context, listen: false);
    // prov.setJob(jobList);

    // List<JobModel> sortedList = prov.sortJobMod(jobList);
    if (jobList.isEmpty) {
      return Column(
        children: [_hasNoJobsAvailableMethod(size)],
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: jobList.length,
            itemBuilder: (context, index) {
              //  final job = JobModel.fromsnap(snapshot.data!.docs[index]);
              if (jobList[index].postedBy != userModelGlobal.uid) {}

              return JobCardWidget(
                isPosted: false,
                job: jobList[index],
              );
            },
          ),
        )
      ],
    );
  }

  SizedBox _hasNoJobsAvailableMethod(Size size) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .5,
            child: SvgPicture.asset("assets/images/no_job_found_vector.svg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "No jobs found",
              style:
                  GoogleFonts.inter(fontSize: 33, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreenn extends StatelessWidget {
  const HomeScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
