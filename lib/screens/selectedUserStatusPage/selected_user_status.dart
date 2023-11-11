// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:lite_jobs/models/user_model.dart';
// import 'package:lite_jobs/provider/selected_user_status_provider.dart';
// import 'package:lite_jobs/utils/colors/colors.dart';
// import 'package:provider/provider.dart';

// import '../../common/widgets/special_appbar_widget.dart';

// class SelectedUserStatus extends StatelessWidget {
//   const SelectedUserStatus(
//       {super.key, required this.jobid, required this.selectedUser});
//   final String jobid;
//   final String selectedUser;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: Consumer<SelectedUserStatusProvider>(
//           builder: (context, value, child) {
//             return Column(
//               children: [
//                 SpecialAppbar(
//                   appBarTitle: "Status",
//                   context: context,
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 SizedBox(height: size.height * 0.016),
//                 SizedBox(
//                   height: size.height * .36,
//                   child: SvgPicture.asset("assets/images/5538959_2867043.svg"),
//                 ),
//                 StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .where('uid', isEqualTo: selectedUser)
//                       .snapshots(),
//                   builder: (context,
//                       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                           snapshot) {
//                     if (snapshot.hasData) {
//                       final data = snapshot.data!.docs[0];
//                       final usser = UserModel.fromSnap(data);
//                       value.setusername(usser.username);

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/provider/auth_provider.dart';
import 'package:lite_jobs/screens/selectedUserStatusPage/widget/responce_body.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

class SelectedUserStatus extends StatelessWidget {
  const SelectedUserStatus(
      {super.key, required this.jobid, this.selectedUser, this.job});
  final String jobid;
  final String? selectedUser;
  final JobModel? job;

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
            appBarTitle: "Status"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: selectedUser)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs[0];
              final usser = UserModel.fromSnap(data);
              // value.setusername(usser.username);
              return ResponceBody(size: size, usser: usser);
            } else {
              return BlurryModalProgressHUD(
                  inAsyncCall: true,
                  blurEffectIntensity: 8,
                  progressIndicator: const SpinKitWave(
                    color: singInButtonColor,
                    size: 90.0,
                  ),
                  dismissible: false,
                  opacity: 0.4,
                  color: Colors.black,
                  child: ResponceBody(size: size));
            }
          },
        ),
      ),
    ); ////
  }
}

class JobCancelledByPostedUser extends StatelessWidget {
  const JobCancelledByPostedUser({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: SpecialAppbar(
              context: context,
              onTap: () {
                Navigator.pop(context);
              },
              appBarTitle: "Status"),
          body: Column(
            children: [
              SizedBox(height: size.height * 0.016),
              SizedBox(
                  height: size.height * .36,
                  child: SvgPicture.asset("assets/images/job_cancelled.svg")),
              Text(
                "you, ${prov.getUserModel.username}",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "has cancelled the job",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              SizedBox(
                // color: Colors.red,
                width: 342,
                child: Center(
                  child: Text(
                    "it is  understandable that you might have some difficulties , you had a change of mind we can understand . feel free to post new job any time ",
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      wordSpacing: .5,
                      letterSpacing: .1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(182, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: BorderSide(color: Colors.grey.shade400)),
                onPressed: () async {
                  String res = "something went wrong";
                  try {
                    await FirebaseFirestore.instance
                        .collection('Jobs')
                        .doc(job.jobId)
                        .delete();
                    res = "Job removed From the list";
                  } catch (e) {
                    res = e.toString();
                  }

                  Utils().showSnackBarMessage(context: context, content: res);
                  if (res == "Job removed From the list") {
                    Navigator.of(context).pop();
                  }
                },
                child: Wrap(
                  children: [
                    Text(
                      "Remove Job from List",
                      style: GoogleFonts.inter(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const LineIcon.ban(
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
