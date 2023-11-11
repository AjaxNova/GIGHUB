import 'package:flutter/material.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          },
          appBarTitle: "Privacy Policy",
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Last updated: 31/10/23",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our JobTok app.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "We may collect and process the following information:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "- Personal Information: This includes your name, age, and email address, which you provide when using our app.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "- Photos: We may collect photos that you upload to your profile or share within the app.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "We use this information to:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "- Facilitate Job Postings: Your personal information is used to create and manage job postings on our platform.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "- Match Job Seekers: We may use your information to match job seekers with suitable job postings.",
                style: TextStyle(fontSize: 16),
              ),
              // Add more content for your privacy policy here.
            ],
          ),
        ),
      ),
    );
  }
}
