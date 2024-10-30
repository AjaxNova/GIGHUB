import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/appliedJobStatus/applied_job_status.dart';
import 'package:lite_jobs/view/screens/selectedUserStatusPage/selected_user_status.dart';

import '../../jobDescription/job_description_page.dart';
import '../../postedJobStatus/posted_job_status.dart';

class JobCardWidget extends StatelessWidget {
  final JobModel job;
  final bool isPosted;
  final bool isApplied;

  const JobCardWidget(
      {super.key,
      required this.job,
      this.isPosted = false,
      this.isApplied = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPosted && job.isCancelled) {
          Utils().navigateMe(
              context: context,
              page: JobCancelledByPostedUser(
                job: job,
              ));
        } else if (isApplied) {
          Utils().navigateMe(
              context: context,
              page: CurrentJobResponcePageApplied(jobid: job.jobId));
        } else if (isPosted && job.selectedUser != "not selected") {
          Utils().navigateMe(
              context: context,
              page: CurrentJobResponcePagePosted(
                jobid: job.jobId,
              ));
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => SelectedUserStatus(
          //       jobid: job.jobId, selectedUser: job.selectedUser),
          // ));
          // Utils().navigateMe(
          //     context: context,
          //     page: SelectedUserStatus(
          //       selectedUser: job.selectedUser,
          //       jobid: job.jobId,
          //     ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isPosted
                    ? JobDescriptionPage(
                        job: job,
                        isPosted: isPosted,
                      )
                    : JobDescriptionPage(
                        job: job,
                      ),
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backCard,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(job.date),
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${job.amount}₹/${job.amountType}",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        job.title,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // isPosted
                    //     ? Container(
                    //         height: 37,
                    //         width: 120,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(12),
                    //             color: Colors.amber),
                    //         child: Center(
                    //             child: job.selectedUserStatus == true
                    //                 ? const Text("Waiting")
                    //                 : const Text("Pending")),
                    //       )
                    //     : const SizedBox()
                  ],
                ),
                Text(
                  job.description,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Applied: ${job.appliedUsers!.length}",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
