import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectPersonFromListProvider extends ChangeNotifier {
  bool isLoading = false;

  changeIsLoading() {
    if (isLoading == true) {
      isLoading = false;
    } else {
      isLoading = true;
    }

    log("bool :$isLoading");

    notifyListeners();
  }

  Future<String> selectPersonForJobs({required String uid, jobId}) async {
    String res = "something went wrong";
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'selectedJobs': FieldValue.arrayUnion([jobId]),
      });
      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).update({
        'selectedUser': uid,
        'selectedUserStatus': true,
        'isRejectedBySelectedUser': false,
        'jobStatus': 'selected',
        'isAcceptedBySelectedUser': false
      });

      res = "Applicant Selected";
    } on FirebaseException catch (e) {
      res = e.message.toString();
    }
    return res;
  }
}
