import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
// import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/server/auth/storage_methods.dart';
import 'package:lite_jobs/view/screens/mainJobScreen/main_screen.dart';
import 'package:provider/provider.dart';

class AuthenticationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  Future<String> googleSignUpUser(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required UserCredential cred,
      Uint8List? file}) async {
    name.trim();
    email.trim();
    phone.trim();
    password.trim();
    String result = "something went wrong";
    if (name != "" &&
        email != "" &&
        password != "" &&
        address != "" &&
        phone != "") {
      if (phone.length != 10) {
        result = "enter a valid phone ";
      } else if (file == null) {
        result = "input a profile image";
      } else {
        try {
          // UserCredential cred = await firebaseAuth
          //     .createUserWithEmailAndPassword(email: email, password: password);

          // String photoUrl = await StorageMethods().uploadimageToDb(
          //   uid: ,
          //     childname: "profilePics", file: file, isJobimagePost: false);

          await _firestore.collection('users').doc(cred.user!.uid).set({
            'username': name,
            'uid': cred.user!.uid,
            'email': email,
            'address': address,
            'phoneNumber': phone,
            'postedJobs': [],
            'appliedJobs': [],
            'photoUrl': "photoUrl"
          });

          result = "User Registered";
        } on FirebaseAuthException catch (e) {
          result = e.message.toString();
        }
      }
    } else {
      result = "fill all the fields";
    }

    return result;
  }

  Future<String> signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required Uint8List? file}) async {
    name.trim();
    email.trim();
    phone.trim();
    password.trim();
    String result = "something went wrong";
    if (name != "" &&
        email != "" &&
        password != "" &&
        address != "" &&
        phone != "") {
      if (phone.length != 10) {
        result = "enter a valid phone ";
      } else if (file == null) {
        result = "input a profile image";
      } else {
        try {
          log("trying to create account");
          log("======================-----------=====================");

          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          final prov = Provider.of<AuthProviderData>(context, listen: false);
          prov.setUid(cred.user!.uid);

          await FirebaseAuth.instance.signOut();

          log("created account-----------");
          log("======================-----------=====================");

          String photoUrl = await StorageMethods().uploadimageToDb(
              uid: prov.uid!,
              childname: "profilePics",
              file: file,
              isJobimagePost: false);

          log("======================-----------=====================");

          log("picture Uploaded-----------");

          UserModel userModel = UserModel(
              rejectedJobs: [],
              savedJobs: [],
              highestQual: "not_defined",
              age: "not_defined",
              appliedJobs: [],
              confirmedJobs: [],
              postedJobs: [],
              selectedJobs: [],
              skills: [],
              username: name,
              uid: prov.uid!,
              email: email,
              address: address,
              phone: phone,
              photoUrl: photoUrl);

          await _firestore
              .collection('users')
              .doc(prov.uid)
              .set(userModel.toJson());

          log("==============**********all done*********=================");

          result = "User Registered";
        } on FirebaseAuthException catch (e) {
          result = e.message.toString();
        }
      }
    } else {
      result = "fill all the fields";
    }

    return result;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();
    String result = "something went wrong";
    if (email != "" && password != "") {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "signed In Succesfully ";
      } on FirebaseAuthException catch (e) {
        result = e.message.toString();
      }
    } else {
      result = "fill all the fields";
    }

    return result;
  }

  Future<String> reserPassword(String email) async {
    String message = "something Went wrong";

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      message = "Password reset email is sent";
    } on FirebaseAuthException catch (e) {
      message = e.message.toString();
    }
    return message;
  }

  Future<String> googleSignIn(context) async {
    await Firebase.initializeApp();
    String responce = "something went wrong";
    try {
      // if (kIsWeb) {
      //   GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      //   // googleAuthProvider.addScope("https://www.googleapis.com/auth/contacts");
      //   UserCredential userCredential =
      //       await _auth.signInWithPopup(googleAuthProvider);
      //   final user = userCredential.user;

      //   if (user != null) {
      //     log(user.uid);
      //   }
      //   // if (userCredential.additionalUserInfo!.isNewUser) {
      //   //   responce = "please fill out some informations";
      //   //   Utils().navigateMe(
      //   //       context: context,
      //   //       page: SignUpPage(isGoogleSignin: true, user: userCredential));
      //   //   return responce;
      //   // } else {
      //   //   responce = "user registered";
      //   //   return responce;
      //   // }
      // } else {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

      if (googleuser == null) {
        return responce;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleuser.authentication;
      if (googleAuth.accessToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          final prov = Provider.of<AuthProviderData>(context, listen: false);
          prov.setUid(userCredential.user!.uid);

          if (userCredential.additionalUserInfo!.isNewUser) {
            responce = "please fill out some informations";
            // Utils().navigateMe(
            //     context: context,
            //     page: SignUpPage(isGoogleSignin: true, user: userCredential));
            return responce;
            // Utils().showSnackBarMessage(
            //     context: context, content: "fill some informations");
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          }
        } else {
          return responce;
        }
      } else {
        return responce;
      }
    } catch (e) {
      log(e.toString());
      responce = e.toString();
    }
    return responce;
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }
}
