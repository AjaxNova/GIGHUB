import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/controller/provider/post_job_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/server/auth/storage_methods.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadJob({
    required String postedBy,
    required Uint8List file,
    required BuildContext context,
    required String amount,
    required String description,
    required String place,
    required String title,
  }) async {
    String amOrpm;

    String res = "something went wrong";
    final provi = Provider.of<PostJobScreenProvider>(context, listen: false);

    if (provi.selectedTime.hour >= 12 && provi.selectedTime.minute > 0) {
      amOrpm = "pm";
    } else {
      amOrpm = "am";
    }

    try {
      String thisPhotourl = await StorageMethods().uploadimageToDb(
          childname: "jobs", file: file, isJobimagePost: true, uid: postedBy);
      String thisJobId = const Uuid().v1();

      JobModel jobModel = JobModel(
        rejectedUserList: [],
        postedTime: DateTime.now(),
        amountType: provi.amountType,
        postedBy: postedBy,
        amount: int.parse(amount),
        appliedUsers: [],
        date: provi.selectedDate,
        description: description,
        isCompleted: false,
        isRejectedBySelectedUser: false,
        isSelected: false,
        jobId: thisJobId,
        place: place,
        requirements: provi.requirements,
        selectedUser: "not selected",
        selectedUserStatus: false,
        time:
            "${provi.selectedTime.hour.toString()}:${provi.selectedTime.minute.toString()} $amOrpm",
        title: title,
        photoUrl: thisPhotourl,
      );

      await _firestore.collection("Jobs").doc(thisJobId).set(jobModel.toJson());
      await _firestore.collection("users").doc(postedBy).update({
        'postedJobs': FieldValue.arrayUnion([thisJobId]),
      });
      res = "success";
      return res;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  saveToBookmark(String jobId, uid) async {
    String res = "something went wrong";
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'savedJobs': FieldValue.arrayUnion([jobId])
      });
      res = "saved to favorites";
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  removeFromSavedJobs(String jobId, uid) async {
    String res = "something went wrong";
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'savedJobs': FieldValue.arrayRemove([jobId])
      });
      res = "success";
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }
}
