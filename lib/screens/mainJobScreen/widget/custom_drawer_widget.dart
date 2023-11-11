import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/screens/appliedJobsPage/applied_jobs_page.dart';
import 'package:lite_jobs/screens/auth/initialPage/initial_page.dart';
import 'package:lite_jobs/screens/chatScreen/chat_screen.dart';
import 'package:lite_jobs/screens/postedJobsdetails/posted_jobs_page.dart';
import 'package:lite_jobs/screens/privacyPolicy/privacy_policy.dart';
import 'package:lite_jobs/utils/utils.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // ListTile(
          //   title: const Text('JOb Details'),
          //   onTap: () {
          //     // Utils()
          //     //     .navigateMe(context: context, page: const JobDetailsPage());
          //   },
          // ),
          ListTile(
            title: const Text('Posted Jobs'),
            onTap: () {
              Utils().navigateMe(context: context, page: const PostedJobPage());
            },
          ),
          ListTile(
            title: const Text('Applied Jobs'),
            onTap: () {
              Utils()
                  .navigateMe(context: context, page: const AppliedJobsPage());
            },
          ),

          ListTile(
            title: const Text('chat'),
            onTap: () {
              Utils().navigateMe(context: context, page: const ChatScreen());
            },
          ),

          ListTile(
            title: const Text('Contact Us'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy policy'),
            onTap: () {
              Utils().navigateMe(
                  context: context, page: const PrivacyPolicyPage());
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {},
          ),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const InitialPage()),
                  (route) => false,
                );
              },
              child: const Text("Signout"))
        ],
      ),
    );
  }
}


































































    // TextButton(
          //     onPressed: () {
          //       FirebaseAuth.instance.signOut();
          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => const InitialPage(),
          //       ));
          //     },
          //     child: const Text("Signout"))