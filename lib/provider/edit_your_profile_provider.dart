import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../server/auth/storage_methods.dart';

class EditProfilePageProvider extends ChangeNotifier {
  List<dynamic> skills = [];
  String gender = "Male";
  Uint8List? file;
  bool isLoading = false;
  bool isImageLoading = false;

  changeIsImageLoading() {
    if (isImageLoading) {
      isImageLoading = false;
    } else {
      isImageLoading = true;
    }
    notifyListeners();
  }

  setImage(Uint8List fetch) {
    file = fetch;
    notifyListeners();
  }

  removeFromSkills(int index) {
    skills.removeAt(index);
    notifyListeners();
  }

  resetVal() {
    skills = [];
    gender = "Male";
    file = null;
    notifyListeners();
  }

  setGender(String gend) {
    gender = gend;
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

  setVal({required String gend, required List<dynamic> skill}) {
    skills = skill;
    gender = gend;
    // notifyListeners();
  }

  setVals({required String gend, required List<dynamic> skill}) {
    skills = skill;
    gender = gend;
    // notifyListeners();
  }

  addToListSkill(String skill) {
    skills.add(skill);
    notifyListeners();
  }

  Future<String> onEditButton(
      {required String uid,
      required String name,
      required String highestQual,
      required String age,
      required String currentPhotoUrl,
      required String bio}) async {
    log("name:$uid");

    String res = "something went wrong";
    String photoUrl = currentPhotoUrl;

    try {
      if (file != null) {
        photoUrl = await StorageMethods().uploadimageToDb(
            uid: uid,
            childname: "profilePics",
            file: file!,
            isJobimagePost: false);
        log("picture posted");

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          "username": name,
          "age": age,
          "highestQual": highestQual,
          "gender": gender,
          "bio": bio,
          "skills": skills,
          "finishProfile": true,
          "photoUrl": photoUrl
        });
        res = "success";
        return res;
      } else {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          "username": name,
          "age": age,
          "highestQual": highestQual,
          "gender": gender,
          "bio": bio,
          "skills": skills,
          "finishProfile": true,
        });
        res = "success";
        return res;
      }
    } catch (e) {
      res = e.toString();
      log(res);

      return res;
    }
  }
}
