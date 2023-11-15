import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/server/firestore_methods.dart';
import 'package:lite_jobs/utils/utils.dart';

class PostJobScreenProvider extends ChangeNotifier {
  final FirestoreMethods firestoreMethods = FirestoreMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> requirements = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Uint8List? file;
  bool postJObIsLoading = false;

  changeLoading() {
    if (postJObIsLoading) {
      postJObIsLoading = false;
    } else {
      postJObIsLoading = true;
    }
    notifyListeners();
  }

  String amountType = "month";

  void setAmountType(String val) {
    amountType = val;
    notifyListeners();
  }

  void resetValues() {
    amountType = "month";
    requirements.clear();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    file = null;

    notifyListeners();
  }

  void setImage(image) {
    file = image;
    notifyListeners();
  }

  void removeFromRequireMents(int index) {
    requirements.removeAt(index);
    notifyListeners();
  }

  void addRequirement(TextEditingController requirementController) {
    if (requirementController.text.isNotEmpty) {
      requirements.add(requirementController.text);
      notifyListeners();
      requirementController.clear();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
      notifyListeners();
    }
  }

  Future<String> onPOstJobButton(
      {required BuildContext context,
      required String amount,
      required String description,
      required String place,
      required String title}) async {
    String postedBy = _auth.currentUser!.uid;

    String res = "something went wrong";
    try {
      res = await firestoreMethods.uploadJob(
        postedBy: postedBy,
        file: file!,
        context: context,
        amount: amount,
        description: description,
        place: place,
        title: title,
      );
      if (res == "success") {
        Utils().showSnackBarMessage(context: context, content: "job posted");
        return res;
      } else {
        Utils().showSnackBarMessage(context: context, content: res);
        return res;
      }
    } catch (e) {
      Utils().showSnackBarMessage(context: context, content: e.toString());
      return res;
    }

    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // await firebaseFirestore.doc(jobId).set(jobModel.toJson());
  }
}
