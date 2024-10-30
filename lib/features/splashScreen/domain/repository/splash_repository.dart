import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/splashScreen/domain/entities/user_model_entity.dart';

abstract class SplashRepository {
  Future<DataState<UserModelEntity>> getUserDetails();
}
