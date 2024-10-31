import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/entities/user_model_entity.dart';

class FinishProfileModel extends UserModelEntity {
  FinishProfileModel(
      {required super.finishProfile,
      required super.username,
      required super.uid,
      required super.email,
      required super.address,
      required super.phone,
      required super.photoUrl,
      required super.age,
      required super.postedJobs,
      required super.highestQual,
      required super.skills,
      required super.appliedJobs,
      required super.selectedJobs,
      required super.confirmedJobs,
      required super.savedJobs,
      required super.rejectedJobs});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'uid': uid,
      'email': email,
      'phone': phone,
      'age': age,
      'address': address,
      'photoUrl': photoUrl,
      'postedJobs': postedJobs,
      'highestQual': highestQual,
      'skills': skills,
      'appliedJobs': appliedJobs,
      'selectedJobs': selectedJobs,
      'confirmedJobs': confirmedJobs,
      'savedJobs': savedJobs,
      'rejectedJobs': rejectedJobs,
      'finishProfile': finishProfile
    };
  }

  factory FinishProfileModel.fromSnap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return FinishProfileModel(
      finishProfile: data['finishProfile'],
      rejectedJobs: data['rejectedJobs'],
      savedJobs: data['savedJobs'],
      username: data['username'],
      uid: data['uid'],
      email: data['email'],
      phone: data['phone'],
      age: data['age'],
      address: data['address'],
      photoUrl: data['photoUrl'],
      postedJobs: data['postedJobs'],
      highestQual: data['highestQual'],
      skills: data['skills'],
      appliedJobs: data['appliedJobs'],
      selectedJobs: data['selectedJobs'],
      confirmedJobs: data['confirmedJobs'],
    );
  }
}
