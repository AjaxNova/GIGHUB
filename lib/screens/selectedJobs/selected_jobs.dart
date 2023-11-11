import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/provider/auth_provider.dart';
import 'package:lite_jobs/screens/mainJobScreen/widget/job_card_widget.dart';
import 'package:provider/provider.dart';

class SelectedJobs extends StatelessWidget {
  const SelectedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: SpecialAppbar(
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          },
          appBarTitle: "Selected jobs"),
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
            if (userMod.selectedJobs.length == 0) {
              return const Center(
                child: Text("Nothing found"),
              );
            }
            return SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: userMod.selectedJobs.length,
                  itemBuilder: (context, index) {
                    final jobid = userMod.selectedJobs[index];
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Jobs')
                          .doc(jobid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              jobSnapshot) {
                        if (jobSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final jobMod = JobModel.fromsnap(
                              jobSnapshot.data as DocumentSnapshot<Object?>);
                          return JobCardWidget(job: jobMod);
                        }
                      },
                    );
                  },
                ));
          }
        },
      ),
    ));
  }
}
