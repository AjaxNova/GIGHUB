import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/finishYourProfile/data/data_source/finish_your_profile_services.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/repository/finish_profile_repository.dart';

class FinishProfileRepositoryImpl extends FinishProfileRepository {
  FinishProfileRepositoryImpl(this._finishYourProfileServices);

  final FinishYourProfileServices _finishYourProfileServices;

  @override
  Future<DataState<UserModelEntity>> finishYourProfile(
      {required String qualification,
      required String uid,
      required String age,
      required String gender,
      required List<String> skill,
      required String bio}) async {
    try {
      final data = await _finishYourProfileServices.finishYourProfile(
          qualification: qualification,
          uid: uid,
          age: age,
          gender: gender,
          skill: skill,
          bio: bio);
      if (data == null) {
        return const DataFailed('something went wrong');
      } else {
        return DataSuccess(data);
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
