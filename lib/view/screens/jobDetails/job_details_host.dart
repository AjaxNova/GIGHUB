import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/models/user_model.dart';

import '../auth/widget/custom_button.dart';

class JobDetailsPage extends StatelessWidget {
  final JobModel job;
  const JobDetailsPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          Text(
                            'Driver',
                            style: GoogleFonts.inter(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'i need a driver for a small trip around 12 km up and down from my home to kondotty Sbi bank and wait for me and drive back ',
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'Date: September 10, 2023',
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Time: 9:00 AM - 5:00 PM',
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 3,
                    height: 4,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
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
                      const RequirementTexts(
                          content: "must have 4 - wheelers license"),
                      const RequirementTexts(content: "must be 30+years old"),
                      const RequirementTexts(
                          content: "should speak English  fluently "),
                      const RequirementTexts(
                          content:
                              "should know how to handle automatic  vehicle"),
                      const RequirementTexts(
                          content:
                              "should know little bit repair work like changing tire etc.."),
                      const RequirementTexts(
                          content: "prefer a slow and safe driver"),
                      const RequirementTexts(
                          content: "must have 4 - wheelers license"),
                      const RequirementTexts(
                          content: "must have 4 - wheelers license"),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 3,
                    height: 4,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Utils().navigateMe(
                    //     context: context, page: const ViewApplicants());
                  },
                  child: Container(
                    height: 60,
                    //padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8CD2DB),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      // onTap: () {
                      //   Utils().navigateMe(
                      //       context: context, page: const ViewApplicants());
                      // },
                      title: Text('View Applicants',
                          style: GoogleFonts.inter(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          )),
                      trailing: Wrap(
                        children: [
                          const SizedBox(
                            width: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xFFF54A4A),
                                  radius: 18.0,
                                  child: Icon(Icons.person),
                                ),
                                Positioned(
                                  left: 33.0,
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF0469FF),
                                    radius: 18.0,
                                    child: Icon(Icons.person),
                                  ),
                                ),
                                Positioned(
                                  left: 45.0,
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF0AFF22),
                                    radius: 18.0,
                                    child: Icon(Icons.person),
                                  ),
                                ),
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomButton(
                        buttonText: "already applied:13",
                        color: const Color(0xFF84E9B8),
                        borderColor: Colors.grey,
                        elevation: 0,
                        onTap: () {}),
                    Expanded(
                      child: CustomButton(
                          buttonText: "Cancel",
                          color: const Color(0xFFE98A84),
                          borderColor: Colors.grey,
                          elevation: 0,
                          onTap: () {}),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequirementTexts extends StatelessWidget {
  final String content;
  const RequirementTexts({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• $content',
          style: GoogleFonts.inter(
            height: 1.5,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
