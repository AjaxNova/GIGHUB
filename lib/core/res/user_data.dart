import 'package:lite_jobs/features/splashScreen/domain/entities/user_model_entity.dart';

late UserModelEntity globalUserModel;

setUser(UserModelEntity user) {
  globalUserModel = user;
}
