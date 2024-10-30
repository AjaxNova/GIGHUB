import 'package:equatable/equatable.dart';

class UserModelGlobal extends Equatable {
  String username;
  String uid;
  String phone;
  String email;
  String age;
  String address;
  String gender;
  dynamic skills;
  String highestQual;
  String photoUrl;
  String bio;
  bool finishProfile;
  dynamic savedJobs;
  dynamic appliedJobs;
  dynamic postedJobs;
  dynamic selectedJobs;
  dynamic confirmedJobs;
  dynamic rejectedJobs;

  UserModelGlobal({
    required this.username,
    required this.uid,
    required this.email,
    required this.address,
    required this.phone,
    required this.photoUrl,
    required this.age,
    required this.postedJobs,
    required this.highestQual,
    required this.skills,
    required this.appliedJobs,
    required this.selectedJobs,
    required this.confirmedJobs,
    required this.savedJobs,
    required this.rejectedJobs,
    required this.finishProfile,
    this.gender = "notSelected",
    this.bio = "notSelected",
  });

  @override
  List<Object?> get props {
    return [
      username,
      uid,
      phone,
      email,
      age,
      address,
      gender,
      skills,
      highestQual,
      photoUrl,
      bio,
      finishProfile,
      savedJobs,
      appliedJobs,
      postedJobs,
      selectedJobs,
      confirmedJobs,
      rejectedJobs
    ];
  }
}
