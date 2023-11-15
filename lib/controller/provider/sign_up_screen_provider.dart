import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/screens/splashScreen/splash_screen.dart';
import 'package:lite_jobs/server/auth/auth_functions.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../screens/auth/signIn/sing_in.dart';
import '../../server/auth/storage_methods.dart';

class SignUpScreenProvider extends ChangeNotifier {
  final AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool isLoading = false;
  bool isImageIsLoading = false;
  Uint8List? fetchImage;
  bool isGoogleDeleting = false;

  changeisGoogleDeleting() {
    if (isGoogleDeleting == false) {
      isGoogleDeleting = true;
    } else {
      isGoogleDeleting = false;
    }
    notifyListeners();
  }

  changeIsLoading() {
    if (isLoading == true) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    notifyListeners();
  }

  changeIsImageLoading() {
    if (isImageIsLoading == true) {
      isImageIsLoading = false;
    } else {
      isImageIsLoading = true;
    }
    notifyListeners();
  }

  setImage(Uint8List file) {
    fetchImage = file;
    notifyListeners();
  }

  clearImage() {
    fetchImage = null;
  }

  onregisterbutton({
    required bool isGoogleSignin,
    required String address,
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    String res = "something went wrong";
    if (isGoogleSignin) {
      changeIsLoading();

      try {
        final prov = Provider.of<AuthProvider>(context, listen: false);
        String photoUrl = await StorageMethods().uploadimageToDb(
            uid: prov.uid!,
            childname: "profilePics",
            file: fetchImage!,
            isJobimagePost: false);

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

        await FirebaseFirestore.instance
            .collection('users')
            .doc(prov.uid)
            .set(userModel.toJson());

        res = "user registered";
        if (context.mounted) {
          Utils().showSnackBarMessage(context: context, content: res);

          if (res == "user registered") {
            clearImage();
            prov.refreshUser();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            ));
          }
        }
      } on FirebaseAuthException catch (e) {
        res = e.message.toString();
        Utils().showSnackBarMessage(context: context, content: res);
      }

      // String messege = await authenticationMethods.signUpUser(
      //     context: context,
      //     address: address,
      //     name: name,
      //     email: email,
      //     phone: phone,
      //     password: password,
      //     file: fetchImage);
      // changeIsLoading();

      // if (context.mounted) {
      //   Utils().showSnackBarMessage(context: context, content: messege);
      //   if (messege == "User Registered") {
      //     FirebaseAuth.instance.signOut();
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => const SignInPage(),
      //     ));
      //   }
      // }
    } else {
      changeIsLoading();
      // setState(() {
      //   isLoading = true;
      // });

      String message = await authenticationMethods.signUpUser(
          context: context,
          address: address,
          name: name,
          email: email,
          phone: phone,
          password: password,
          file: fetchImage);
      changeIsLoading();
      // setState(() {
      //   isLoading = false;
      // });

      if (context.mounted) {
        Utils().showSnackBarMessage(context: context, content: message);
        if (message == "User Registered") {
          clearImage();

          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ));
        }
      }
    }
  }
}
