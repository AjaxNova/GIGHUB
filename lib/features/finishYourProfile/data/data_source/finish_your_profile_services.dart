import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lite_jobs/features/finishYourProfile/data/model/finish_profile_model.dart';

class FinishYourProfileServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<FinishProfileModel?> finishYourProfile(
      {required String qualification,
      required String uid,
      required String age,
      required String gender,
      required List<String> skill,
      required String bio}) async {
    try {
      _firestore.collection('users').doc(uid).update({
        "age": age,
        "highestQual": qualification,
        "gender": gender,
        "bio": bio,
        "skills": skill,
        "finishProfile": true
      });
      final data = await _firestore.collection('users').doc(uid).get();
      final userModel = FinishProfileModel.fromSnap(data);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
