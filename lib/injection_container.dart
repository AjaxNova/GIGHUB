import 'package:get_it/get_it.dart';
import 'package:lite_jobs/features/auth/data/data_sources/remote/auth_services.dart';
import 'package:lite_jobs/features/auth/data/repository/auth_repository.dart';
import 'package:lite_jobs/features/auth/domain/repository/auth_repository.dart';
import 'package:lite_jobs/features/auth/domain/useCases/sign_in.dart';
import 'package:lite_jobs/features/auth/domain/useCases/sign_up.dart';
import 'package:lite_jobs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lite_jobs/features/finishYourProfile/data/data_source/finish_your_profile_services.dart';
import 'package:lite_jobs/features/finishYourProfile/data/repository/finish_profile_repository.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/repository/finish_profile_repository.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/useCase/finish_profile_usecase.dart';
import 'package:lite_jobs/features/finishYourProfile/presentation/bloc/finish_profile_bloc.dart';
import 'package:lite_jobs/features/splashScreen/data/data_source/splash_services.dart';
import 'package:lite_jobs/features/splashScreen/data/repository/splash_repository.dart';
import 'package:lite_jobs/features/splashScreen/domain/repository/splash_repository.dart';
import 'package:lite_jobs/features/splashScreen/domain/useCases/get_user_usecase.dart';
import 'package:lite_jobs/features/splashScreen/presentation/bloc/splash_screen_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependacies() async {
  sl.registerSingleton<AuthServices>(AuthServices());
  sl.registerSingleton<SplashServices>(SplashServices());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerSingleton<SplashRepository>(SplashRepositoryImpl(sl()));
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase(sl()));
  sl.registerFactory<SplashScreenBloc>(() => SplashScreenBloc(sl()));
  sl.registerSingleton<FinishYourProfileServices>(FinishYourProfileServices());
  sl.registerSingleton<FinishProfileRepository>(
      FinishProfileRepositoryImpl(sl()));
  sl.registerSingleton<FinishProfileUsecase>(FinishProfileUsecase(sl()));
  sl.registerFactory<FinishProfileBloc>(() => FinishProfileBloc(sl()));
}
