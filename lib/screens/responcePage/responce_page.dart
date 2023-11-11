

// class ResponcePage extends StatelessWidget {
//   const ResponcePage(
//       {super.key, required this.jobId, required this.selectedUser});
//   final String jobId;
//   final String selectedUser;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         appBar: SpecialAppbar(
//             context: context, onTap: () {}, appBarTitle: "Status"),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('Jobs')
//               .where('jobId', isEqualTo: jobId)
//               .snapshots(),
//           builder: (context,
//               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> jobSnapshot) {
//             if (jobSnapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               final jobMod = JobModel.fromsnap(jobSnapshot.data!.docs[0]);

//               return StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .where('uid', isEqualTo: selectedUser)
//                     .snapshots(),
//                 builder: (context,
//                     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                         userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else {
//                     final UserMod =
//                         UserModel.fromSnap(userSnapshot.data!.docs[0]);
//                     if (jobMod.isRejectedBySelectedUser) {
//                       return const SizedBox();
//                     } else if (jobMod.isAcceptedBySelectedUser == false &&
//                         jobMod.isRejectedBySelectedUser == false) {
//                       return Column(
//                         children: [
//                           SizedBox(height: size.height * 0.016),
//                           SizedBox(
//                             height: size.height * .36,
//                             child: SvgPicture.asset(
//                                 "assets/images/5538959_2867043.svg"),
//                           ),
//                           Text(
//                             UserMod.username,
//                             style: GoogleFonts.inter(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 25,
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.01,
//                           ),
//                           Text(
//                             "has confirmed the offer",
//                             style: GoogleFonts.inter(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 25,
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.045,
//                           ),
//                           SizedBox(
//                             // color: Colors.red,
//                             width: 342,
//                             child: Center(
//                               child: Text(
//                                 "now you can chat with ${UserMod.username} in the chat screen . be polite and humble in the chat always remember give respect and take respect",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15.5,
//                                   wordSpacing: .5,
//                                   letterSpacing: .1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.09,
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 elevation: 2,
//                                 backgroundColor: Colors.white,
//                                 minimumSize: const Size(182, 50),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 side: BorderSide(color: Colors.grey.shade400)),
//                             onPressed: () {},
//                             child: Wrap(
//                               children: [
//                                 Text(
//                                   "Chat",
//                                   style: GoogleFonts.inter(
//                                       fontSize: 19,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black),
//                                 ),
//                                 const LineIcon.facebookMessenger(
//                                   color: messengerIconColor,
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       );
//                     } else if (jobMod.isAcceptedBySelectedUser == true) {
//                       return const SizedBox();
//                     } else {
//                       return const SizedBox();
//                     }
//                   }
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

