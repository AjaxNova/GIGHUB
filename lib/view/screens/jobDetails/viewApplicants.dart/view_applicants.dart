import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/jobDetails/viewApplicants.dart/applicantDetails/applicant_details.dart';
import 'package:lite_jobs/view/screens/profilePage/profile_page.dart';

class ApplicantWidgwt extends StatelessWidget {
  final JobModel job;
  const ApplicantWidgwt({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF8CD2DB),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: ListTile(
          onTap: () {
            Utils()
                .navigateMe(context: context, page: const ApplicantDetails());
          },
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFF54A4A),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Alex Akhif',
            style:
                GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class AppbarForViewApplicantsPage extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarForViewApplicantsPage({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const LineIcon.arrowCircleLeft(
                size: 42,
              ),
            ),
          ),
          Text(
            "Applicants List",
            style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const SizedBox(
                  child: Icon(
                Icons.filter_alt_outlined,
                size: 33,
              )),
              const SizedBox(
                width: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.grey.shade900),
                    borderRadius: BorderRadius.circular(25)),
                height: 40,
                width: 40,
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 19,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ViewApplicantsPage extends StatelessWidget {
  const ViewApplicantsPage({super.key, required this.jobid});

  final String jobid;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
            appBarTitle: "Applicants List"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // const AppbarForViewApplicantsPage(),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Jobs")
                    .where("jobId", isEqualTo: jobid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = snapshot.data!.docs;
                    final job = JobModel.fromsnap(data[0]);

                    List<dynamic> appliedUsers = job.appliedUsers;
                    final List<dynamic> rejectedUsers = job.rejectedUserList;
                    appliedUsers.removeWhere(
                        (element) => rejectedUsers.contains(element));

                    if (appliedUsers.isEmpty) {
                      return SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * .55,
                              child: SvgPicture.asset(
                                  "assets/images/no_users_applied_yet.svg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "No user applied",
                                style: GoogleFonts.inter(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: appliedUsers.length,
                        itemBuilder: (context, index) {
                          final uuser = appliedUsers[index];
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .where("uid", isEqualTo: uuser)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: test1),
                                  child: const ListTile(),
                                );
                              } else {
                                final data = snapshot.data!.docs[0];
                                final uuuser = UserModel.fromSnap(data);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: test1),
                                    child: ListTile(
                                      onTap: () {
                                        Utils().navigateMe(
                                            context: context,
                                            page: ProfilePage(
                                              user: uuuser,
                                              jobId: jobid,
                                              isApplicant: true,
                                            )
                                            //  JobHostDetailsPage(
                                            //   user: uuuser,
                                            //   jobId: jobid,
                                            //   isApplicant: true,
                                            // )
                                            );
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(uuuser.photoUrl),
                                      ),
                                      title: Text(uuuser.username),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ApplicantPage extends StatelessWidget {
  const ApplicantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
