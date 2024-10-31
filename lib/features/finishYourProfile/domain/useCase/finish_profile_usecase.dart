import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/core/useCase/use_case.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/repository/finish_profile_repository.dart';

class FinishProfileParams {
  final String qualification;
  final String uid;
  final String age;
  final String gender;
  final List<String> skill;
  final String bio;

  FinishProfileParams(this.qualification, this.uid, this.age, this.gender,
      this.skill, this.bio);
}

class FinishProfileUsecase
    implements UseCase<DataState<UserModelEntity>, FinishProfileParams> {
  final FinishProfileRepository _finishProfileRepository;

  FinishProfileUsecase(this._finishProfileRepository);

  @override
  Future<DataState<UserModelEntity>> call(
      {required FinishProfileParams params}) {
    return _finishProfileRepository.finishYourProfile(
        age: params.age,
        bio: params.bio,
        gender: params.gender,
        qualification: params.qualification,
        skill: params.skill,
        uid: params.uid);
  }
}
