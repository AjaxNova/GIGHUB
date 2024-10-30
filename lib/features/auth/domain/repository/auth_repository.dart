import 'dart:typed_data';

import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/auth/domain/entities/user_model_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserModelEntity>> signUp(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required Uint8List file});

  Future<DataState<UserModelEntity>> signIn(
      {required String email, required String password});
}
