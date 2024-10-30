import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lite_jobs/features/splashScreen/data/model/auth_user_model.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<SplashUserModel?> getUserDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snap =
            await _firestore.collection("users").doc(currentUser.uid).get();
        return SplashUserModel.fromSnap(snap);
      }
    } catch (e) {
      throw Exception('User Not Found');
    }
    return null;
  }
}
