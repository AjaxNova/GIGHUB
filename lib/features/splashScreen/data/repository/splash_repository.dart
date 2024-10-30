import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/splashScreen/data/data_source/splash_services.dart';
import 'package:lite_jobs/features/splashScreen/data/model/auth_user_model.dart';
import 'package:lite_jobs/features/splashScreen/domain/repository/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl(this._splashServices);
  final SplashServices _splashServices;
  @override
  Future<DataState<SplashUserModel>> getUserDetails() async {
    try {
      final data = await _splashServices.getUserDetails();
      if (data != null) {
        return DataSuccess(data);
      } else {
        return const DataFailed('User Not Found');
      }
    } catch (e) {
      return const DataFailed('User not Found');
    }
  }
}
