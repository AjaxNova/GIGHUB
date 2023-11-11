import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:lite_jobs/models/user_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  String sortBy = "time";

  // String orderBy = "postedTime";

  bool descending = true;

  List<JobModel> jobs = [];

  setJob(List<JobModel> job) {
    jobs = job;
    notifyListeners();
  }

  // setJobMod(jobmods) {
  //   jobs = jobmods;
  //   notifyListeners();
  // }

  sortJobMod() {
    log("wearehere");
    if (sortBy == "time") {
      jobs.sort((a, b) => b.postedTime.compareTo(a.postedTime));
    } else if (sortBy == "title") {
      jobs.sort((a, b) => a.title.compareTo(b.title));
    } else if (sortBy == "price") {
      jobs.sort((a, b) => b.amount.compareTo(a.amount));
      log("${jobs[0].amount} ${jobs[1].amount}");
    } else if (sortBy == "applications") {
      jobs.sort(
          (a, b) => a.appliedUsers.length.compareTo(b.appliedUsers.length));
    }
    notifyListeners();
  }

  setSortType(String sort) {
    if (sort == "time") {
      sortBy = "postedTime";
      descending = true;
      notifyListeners();
    } else if (sort == "price") {
      sortBy = "amount";
      descending = true;
      notifyListeners();
    } else {
      sortBy = "title";
      descending = false;
      notifyListeners();
    }
    // sortJobMod();
    log(sortBy);

    notifyListeners();
  }

  // setDataToJobList(String uid) async {
  //   final jobData = await FirebaseFirestore.instance
  //       .collection('Jobs')
  //       .where('isCancelled', isEqualTo: false)
  //       .where('postedBy', isNotEqualTo: uid)
  //       .orderBy('postedBy', descending: false)
  //       .orderBy('postedTime', descending: true)
  //       .get();
  //   jobs = jobData.docs.map((doc) => JobModel.fromsnap(doc)).toList();
  //   log(jobs.length.toString());
  //   notifyListeners();
  // }
}
