// import 'package:flutter/material.dart';
// import 'package:lite_jobs/mock/widgets/but_job_card.dart';
// import 'package:lite_jobs/models/user_model.dart';

// class PostJobCardPage extends StatelessWidget {
//   final List<JobModel> alljobs = [
//     JobModel(
//       isCompleted: false,
//       isSelected: false,
//       isRejectedBySelectedUser: false,
//       appliedUsers: [],
//       selectedUser: "not defined",
//       selectedUserStatus: false,
//       title: "Driver",
//       description: "drive me up and down ",
//       amount: "10000",
//       amountType: "month",
//       place: "ozhukur",
//       date: DateTime.now(),
//       time: "4:15",
//       requirements: [],
//       jobId: "sdfsddfsdf",
//       postedBy: "sdsdf",
//       photoUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoO3wlcGNwC8_TOByOAfLokhcSYKTJYQnVpw",
//     ),
//     JobModel(
//       isCompleted: false,
//       isSelected: false,
//       isRejectedBySelectedUser: false,
//       appliedUsers: [],
//       selectedUser: "not defined",
//       selectedUserStatus: false,
//       title: "teacher",
//       description: "teach  me up and down ",
//       amount: "12000",
//       amountType: "year",
//       place: "kondotty",
//       date: DateTime.now(),
//       time: "10:15",
//       requirements: [],
//       jobId: "sdfsddfsdf",
//       postedBy: "sdsdf",
//       photoUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoO3wlcGNwC8_TOByOAfLokhcSYKTJYQnVpw",
//     ),
//     JobModel(
//       isCompleted: false,
//       isSelected: false,
//       isRejectedBySelectedUser: false,
//       appliedUsers: [],
//       selectedUser: "not defined",
//       selectedUserStatus: false,
//       title: "youtuber",
//       description: "youtube  me up and down ",
//       amount: "10000",
//       amountType: "month",
//       place: "ozhukur",
//       date: DateTime.now(),
//       time: "4:15",
//       requirements: [],
//       jobId: "sdfsddfsdf",
//       postedBy: "sdsdf",
//       photoUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoO3wlcGNwC8_TOByOAfLokhcSYKTJYQnVpw",
//     ),
//   ];

//   PostJobCardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: ListView.builder(
//         itemCount: alljobs.length,
//         itemBuilder: (context, index) {
//           return ButJOBCard(alljobs[index]);
//         },
//       ),
//     ));
//   }
// }
