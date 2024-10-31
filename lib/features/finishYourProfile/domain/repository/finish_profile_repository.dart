import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/entities/user_model_entity.dart';

abstract class FinishProfileRepository {
  Future<DataState<UserModelEntity>> finishYourProfile(
      {required String qualification,
      required String uid,
      required String age,
      required String gender,
      required List<String> skill,
      required String bio});
}
