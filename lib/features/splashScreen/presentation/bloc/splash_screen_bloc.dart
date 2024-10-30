import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/core/res/user_data.dart';
import 'package:lite_jobs/features/splashScreen/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/splashScreen/domain/useCases/get_user_usecase.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  GetUserUsecase userUsecase;

  SplashScreenBloc(this.userUsecase) : super(SplashScreenInitial()) {
    on<CheckUserAndNavigateHome>((event, emit) async {
      final data = await userUsecase.call(params: null);
      if (data is DataSuccess) {
        setUser(data.data!);
        emit(SplashSuccessState(user: data.data!));
      } else {
        emit(SplashFailedState(msg: data.error!));
      }
    });
  }
}
