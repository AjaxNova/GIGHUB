import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lite_jobs/features/auth/data/model/auth_user_model.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  uploadimageToDb(
      {required String uid,
      required String childname,
      required Uint8List file,
      required bool isJobimagePost,
      bool isUpdate = false}) async {
    try {
      Reference ref = _storage.ref().child(childname).child(uid);

      if (isUpdate) {
        await ref.delete();
      }

      if (isJobimagePost) {
        String id = const Uuid().v1();
        ref = ref.child(id);
      }
      UploadTask task = ref.putData(file);
      TaskSnapshot snap = await task;

      String url = await snap.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthUserModel?> signUpUser(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required Uint8List? file}) async {
    name.trim();
    email.trim();
    phone.trim();
    password.trim();

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userUid = cred.user!.uid;

      await FirebaseAuth.instance.signOut();

      String? photoUrl = await uploadimageToDb(
          uid: userUid,
          childname: "profilePics",
          file: file!,
          isJobimagePost: false);
      if (photoUrl != null) {
        AuthUserModel userModel = AuthUserModel(
            finishProfile: false,
            rejectedJobs: const [],
            savedJobs: const [],
            highestQual: "not_defined",
            age: "not_defined",
            appliedJobs: const [],
            confirmedJobs: const [],
            postedJobs: const [],
            selectedJobs: const [],
            skills: const [],
            username: name,
            uid: userUid,
            email: email,
            address: address,
            phone: phone,
            photoUrl: photoUrl);

        await _firestore
            .collection('users')
            .doc(userUid)
            .set(userModel.toJson());

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<AuthUserModel?> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User currentUser = _auth.currentUser!;
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(currentUser.uid).get();
      return AuthUserModel.fromSnap(snap);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<String> signInUserActual({
  //   required String email,
  //   required String password,
  // }) async {
  //   email.trim();
  //   password.trim();
  //   String result = "something went wrong";
  //   if (email != "" && password != "") {
  //     try {
  //       await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       result = "signed In Succesfully ";
  //     } on FirebaseAuthException catch (e) {
  //       result = e.message.toString();
  //     }
  //   } else {
  //     result = "fill all the fields";
  //   }

  //   return result;
  // }
}
