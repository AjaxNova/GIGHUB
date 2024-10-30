import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/core/useCase/use_case.dart';
import 'package:lite_jobs/features/auth/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/auth/domain/repository/auth_repository.dart';

class SignInUseCaseparams {
  final String email;

  final String password;

  SignInUseCaseparams({
    required this.email,
    required this.password,
  });
}

class SignInUseCase
    implements UseCase<DataState<UserModelEntity>, SignInUseCaseparams> {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<DataState<UserModelEntity>> call(
      {required SignInUseCaseparams params}) {
    return _authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}
