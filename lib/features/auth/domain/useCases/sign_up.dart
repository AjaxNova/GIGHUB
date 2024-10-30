import 'package:flutter/foundation.dart';
import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/core/useCase/use_case.dart';
import 'package:lite_jobs/features/auth/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCaseparams {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final Uint8List file;

  SignUpUseCaseparams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.file,
  });
}

class SignUpUseCase
    implements UseCase<DataState<UserModelEntity>, SignUpUseCaseparams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<DataState<UserModelEntity>> call(
      {required SignUpUseCaseparams params}) {
    return _authRepository.signUp(
      name: params.name,
      email: params.email,
      phone: params.phone,
      password: params.password,
      address: params.address,
      file: params.file,
    );
  }
}
