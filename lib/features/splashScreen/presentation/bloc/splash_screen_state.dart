part of 'splash_screen_bloc.dart';

sealed class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

final class SplashScreenInitial extends SplashScreenState {}

final class SplashSuccessState extends SplashScreenState {
  final UserModelEntity user;
  const SplashSuccessState({required this.user});
}

final class SplashFailedState extends SplashScreenState {
  final String msg;
  const SplashFailedState({required this.msg});
}
