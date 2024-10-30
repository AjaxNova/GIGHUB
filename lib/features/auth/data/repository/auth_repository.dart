// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/auth/data/data_sources/remote/auth_services.dart';
import 'package:lite_jobs/features/auth/data/model/auth_user_model.dart';
import 'package:lite_jobs/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthServices _authServices;
  AuthRepositoryImpl(
    this._authServices,
  );
  @override
  Future<DataState<AuthUserModel>> signUp(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String address,
      required Uint8List file}) async {
    try {
      final user = await _authServices.signUpUser(
          name: name,
          email: email,
          phone: phone,
          password: password,
          address: address,
          file: file);
      if (user != null) {
        return DataSuccess(user);
      } else {
        return const DataFailed('something went wrong');
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<AuthUserModel>> signIn(
      {required String email, required String password}) async {
    try {
      final user =
          await _authServices.signInUser(email: email, password: password);
      if (user != null) {
        return DataSuccess(user);
      } else {
        return const DataFailed('something went wrong');
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
