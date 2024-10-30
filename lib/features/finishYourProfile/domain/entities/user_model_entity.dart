import 'package:lite_jobs/core/res/user_model.dart';

class UserModelEntity extends UserModelGlobal {
  UserModelEntity(
      {required super.username,
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
      required super.rejectedJobs,
      required super.finishProfile});
}
