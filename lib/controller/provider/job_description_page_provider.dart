import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class JobDescriptionProvider extends ChangeNotifier {
  bool isLoading = false;

  changeLoading() {
    if (isLoading) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    notifyListeners();
  }

  String extractMonthDay(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String month = DateFormat.MMMM().format(dateTime); // Full month name
    String day = DateFormat.d().format(dateTime); // Day of the month
    return '$month $day';
  }

  Future<String> applyForJob(String jobId, BuildContext context) async {
    final prov = Provider.of<AuthProviderData>(context, listen: false);
    await prov.refreshUser();

    String res = "something went wrong";
    if (prov.getUserModel.appliedJobs.contains(jobId)) {
      res = "already applied";
      return res;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(prov.getUserModel.uid)
          .update({
        'appliedJobs': FieldValue.arrayUnion([jobId]),
      });

      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).update({
        'appliedUsers': FieldValue.arrayUnion([prov.getUserModel.uid]),
      });

      res = "applied succesfully";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  cancelJobApplication(String jobId, BuildContext context) async {
    final prov = Provider.of<AuthProviderData>(context, listen: false);
    String res = "something went wrong";
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(prov.getUserModel.uid)
          .update({
        'appliedJobs': FieldValue.arrayRemove([jobId]),
      });

      await FirebaseFirestore.instance.collection('Jobs').doc(jobId).update({
        'appliedUsers': FieldValue.arrayRemove([prov.getUserModel.uid]),
      });

      res = "JOb application cancelled";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> cancelPostedjob(String jobId, BuildContext context) async {
    final prov = Provider.of<AuthProviderData>(context, listen: false);
    String res = "something went wrong";
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(prov.getUserModel.uid)
          .update({
        'postedJobs': FieldValue.arrayRemove([jobId]),
      });

      await FirebaseFirestore.instance
          .collection('Jobs')
          .doc(jobId)
          .update({'isCancelled': true});

      res = "job cancelled";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
