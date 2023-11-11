import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/provider/auth_provider.dart';
import 'package:lite_jobs/screens/mainJobScreen/widget/job_card_widget.dart';
import 'package:provider/provider.dart';

class PostedJobPage extends StatelessWidget {
  const PostedJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
          appBarTitle: "Posted jobs",
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Jobs")
                  .where('postedBy', isEqualTo: prov.getUserModel.uid)
                  .where('isCancelled', isEqualTo: false)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
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
                    }
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final job =
                              JobModel.fromsnap(snapshot.data!.docs[index]);

                          return JobCardWidget(
                            job: job,
                            isPosted: true,
                          );
                        },
                      ),
                    ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
