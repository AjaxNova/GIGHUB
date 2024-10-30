import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
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
  String? bio;
  bool finishProfile;
  dynamic savedJobs;
  dynamic appliedJobs;
  dynamic postedJobs;
  dynamic selectedJobs;
  dynamic confirmedJobs;
  dynamic rejectedJobs;
  //when you also agree to the time and dat

  UserModel({
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
    this.gender = "notSelected",
    this.bio = "notSelected",
    this.finishProfile = false,
  });
  Map<String, dynamic> toJson() => {
        "rejectedJobs": rejectedJobs,
        "savedJobs": savedJobs,
        "bio": bio,
        "gender": gender,
        "finishProfile": finishProfile,
        "username": username,
        "uid": uid,
        "email": email,
        "phone": phone,
        "appliedJobs": appliedJobs,
        "age": age,
        "address": address,
        "skills": skills,
        "highestQual": highestQual,
        "postedJobs": postedJobs,
        "selectedJobs": selectedJobs,
        "confirmedJobs": confirmedJobs,
        "photoUrl": photoUrl
      };
  static UserModel fromSnap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    log(data.toString());
    return UserModel(
      rejectedJobs: data['rejectedJobs'],
      savedJobs: data['savedJobs'],
      bio: data['bio'],
      gender: data['gender'],
      finishProfile: data['finishProfile'],
      username: data['username'],
      uid: data['uid'],
      email: data['email'],
      phone: data['phone'],
      appliedJobs: data['appliedJobs'],
      age: data['age'],
      address: data['address'],
      skills: data['skills'],
      highestQual: data['highestQual'],
      postedJobs: data['postedJobs'],
      selectedJobs: data['selectedJobs'],
      confirmedJobs: data['confirmedJobs'],
      photoUrl: data['photoUrl'],
    );
  }
}

class JobModel {
  bool isCancelled;
  bool isCompleted;
  bool isSelected;
  bool isAcceptedBySelectedUser;
  bool isRejectedBySelectedUser;
  dynamic appliedUsers;
  dynamic rejectedUserList;
  String selectedUser;
  bool selectedUserStatus;
  String title;
  String description;
  int amount;
  String amountType;
  String place;
  DateTime date;
  String time;
  dynamic requirements;
  String jobId;
  String postedBy;
  String photoUrl;
  String jobStatus;
  DateTime postedTime = DateTime.now();

  JobModel(
      {required this.isCompleted,
      required this.isSelected,
      required this.isRejectedBySelectedUser,
      required this.appliedUsers,
      required this.selectedUser,
      required this.selectedUserStatus,
      required this.title,
      required this.description,
      required this.amount,
      required this.amountType,
      required this.place,
      required this.date,
      required this.time,
      required this.requirements,
      required this.jobId,
      required this.postedBy,
      required this.photoUrl,
      this.isAcceptedBySelectedUser = false,
      this.isCancelled = false,
      this.jobStatus = "not selected",
      required this.postedTime,
      required this.rejectedUserList});

  static TimeOfDay timeFromString(String s) {
    log(s.toString());
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    return startTime;
  }

  factory JobModel.fromsnap(DocumentSnapshot snap) {
    final postedTimes = (snap['postedTime'] as Timestamp).toDate();

    return JobModel(
      rejectedUserList: snap['rejectedUserList'],
      postedTime: postedTimes,
      jobStatus: snap['jobStatus'],
      isCancelled: snap['isCancelled'],
      isAcceptedBySelectedUser: snap['isAcceptedBySelectedUser'],
      isCompleted: snap['isCompleted'],
      isSelected: snap['isSelected'],
      isRejectedBySelectedUser: snap['isRejectedBySelectedUser'],
      appliedUsers: snap['appliedUsers'],
      selectedUser: snap['selectedUser'],
      selectedUserStatus: snap['selectedUserStatus'],
      title: snap['title'],
      description: snap['description'],
      amount: snap['amount'],
      amountType: snap['amountType'],
      place: snap['place'],
      date: DateTime.parse(snap['date']),
      time: (snap['time']),
      requirements: snap['requirements'],
      jobId: snap['jobId'],
      postedBy: snap['postedBy'],
      photoUrl: snap['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rejectedUserList': rejectedUserList,
      'postedTime': postedTime,
      'jobStatus': jobStatus,
      'isCancelled': isCancelled,
      'isCompleted': isCompleted,
      'isSelected': isSelected,
      'isRejectedBySelectedUser': isRejectedBySelectedUser,
      'appliedUsers': appliedUsers,
      'selectedUser': selectedUser,
      'selectedUserStatus': selectedUserStatus,
      'title': title,
      'description': description,
      'amount': amount,
      'amountType': amountType,
      'place': place,
      'date': date.toIso8601String(),
      'time': time.toString(),
      'requirements': requirements,
      'jobId': jobId,
      'postedBy': postedBy,
      'photoUrl': photoUrl,
      'isAcceptedBySelectedUser': isAcceptedBySelectedUser
    };
  }
}

class CommentModel {
  final String senderId;
  final String recieverId;
  final String message;
  final DateTime sentTime;
  CommentModel(
      {required this.message,
      required this.recieverId,
      required this.senderId,
      required this.sentTime});

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'message': message,
      'sentTime': sentTime
    };
  }

  factory CommentModel.fromsnap(DocumentSnapshot snap) {
    final sentTime = (snap['sentTime'] as Timestamp).toDate();
    return CommentModel(
      message: snap['message'],
      recieverId: snap['recieverId'],
      senderId: snap['senderId'],
      sentTime: sentTime,
    );
  }
}
