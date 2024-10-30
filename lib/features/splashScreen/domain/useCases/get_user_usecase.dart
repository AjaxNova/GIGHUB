import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/core/useCase/use_case.dart';
import 'package:lite_jobs/features/splashScreen/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/splashScreen/domain/repository/splash_repository.dart';

class GetUserUsecase implements UseCase<DataState<UserModelEntity>, void> {
  final SplashRepository _splashRepository;

  GetUserUsecase(this._splashRepository);

  @override
  Future<DataState<UserModelEntity>> call({required params}) async {
    return await _splashRepository.getUserDetails();
  }
}
