import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinishYourProfileProvider extends ChangeNotifier {
  List<String> skill = [];

  String gender = "Male";
  bool isLoading = false;
  bool isImageLoading = false;
  String? photoUrl;

  Future<String> onFinishButton(
      {required String qualification,
      required String uid,
      required String age,
      required String bio}) async {
    String res = "something went wrong";
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        "age": age,
        "highestQual": qualification,
        "gender": gender,
        "bio": bio,
        "skills": skill,
        "finishProfile": true
      });
      res = "success";
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  setPhotoUrl(String url) {
    photoUrl = url;
    notifyListeners();
  }

  setGender(String gend) {
    gender = gend;
    notifyListeners();
  }

  changeIsImageLoading() {
    if (isImageLoading) {
      isImageLoading = false;
    } else {
      isImageLoading = true;
    }
    notifyListeners();
  }

  addToListSkill(String a) {
    if (a != "") {
      skill.add(a);
      notifyListeners();
    }
  }

  removeFromSkills(int index) {
    skill.removeAt(index);
    notifyListeners();
  }

  changeIsLoading() {
    if (isLoading) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    notifyListeners();
  }

  resetValues() {
    gender = "Male";
    skill = [];
  }
}
