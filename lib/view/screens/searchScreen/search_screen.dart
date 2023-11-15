import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/controller/provider/searc_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../mainJobScreen/widget/job_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.uid});
  final String uid;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provAuth = Provider.of<AuthProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        // final prov = Provider.of<SearchScreenProvider>(context, listen: false);
        // prov.isSearchingToFalse();
        // prov.clearSearchName();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: SpecialAppbar(
              searchController: _searchController,
              context: context,
              onTap: () {
                final prov =
                    Provider.of<SearchScreenProvider>(context, listen: false);
                prov.isSearchingToFalse();
                prov.clearSearchName();
                Navigator.of(context).pop();
              },
              appBarTitle: "search",
              isSearch: true,
            ),
            body: Consumer<SearchScreenProvider>(
              builder: (context, value, child) {
                return value.isSearching && value.searchName != ""
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Jobs')
                            .where('title',
                                isGreaterThanOrEqualTo: value.searchName)
                            .where('title', isLessThan: '${value.searchName}z')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.hasData) {
                              final filteredJobs = snapshot.data!.docs
                                  .where((doc) =>
                                      doc['postedBy'] !=
                                          provAuth.getUserModel.uid &&
                                      doc['isCancelled'] == false)
                                  .toList();
                              if (filteredJobs.isEmpty) {
                                return const Center(
                                  child: Text("nothing"),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: filteredJobs.length,
                                    itemBuilder: (context, index) {
                                      final jobMod = JobModel.fromsnap(
                                          filteredJobs[index]);
                                      return JobCardWidget(job: jobMod);
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const Text("no data");
                            }
                          }
                        },
                      )
                    : const SizedBox(
                        child: Center(
                          child: Text("Search Jobs here"),
                        ),
                      );
              },
            )
            //  Consumer<SearchScreenProvider>(
            //   builder: (context, value, child) {
            //     return value.isSearching && value.searchName != ""
            //         ? FutureBuilder(
            //             future: FirebaseFirestore.instance
            //                 .collection('Jobs')
            //                 .where('title',
            //                     isGreaterThanOrEqualTo: value.searchName)
            //                 .where('title', isLessThan: '${value.searchName}z')
            //                 .get(),
            //             builder: (context, snapshot) {
            //               if (snapshot.connectionState ==
            //                   ConnectionState.waiting) {
            //                 return const Center(
            //                     child: CircularProgressIndicator());
            //               } else {
            //                 if (snapshot.hasData) {
            //                   if (snapshot.data!.docs.isEmpty) {
            //                     return const Center(child: Text("no jobs found"));
            //                   } else {
            //                     final job = snapshot.data;
            //                     final filteredJobs = job!.docs.where((doc) =>
            //                         doc['postedBy'] != provAuth.getUserModel.uid);
            //                     if (filteredJobs.isEmpty) {
            //                       return const Center(
            //                         child: Text("no data found"),
            //                       );
            //                     }

            //                     return Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: ListView.builder(
            //                         itemCount: job.docs.length,
            //                         itemBuilder: (context, index) {
            //                           final jobMod =
            //                               JobModel.fromsnap(job.docs[index]);
            //                           return JobCardWidget(job: jobMod);
            //                         },
            //                       ),
            //                     );
            //                   }
            //                 } else {
            //                   return const Text("no data");
            //                 }
            //               }
            //             },
            //           )
            //         : const SizedBox(
            //             child: Center(
            //               child: Text("Search Jobs here"),
            //             ),
            //           );
            //   },
            // ),
            ),
      ),
    );
  }
}
