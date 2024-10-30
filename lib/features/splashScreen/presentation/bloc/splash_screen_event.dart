part of 'splash_screen_bloc.dart';

class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserAndNavigateHome extends SplashScreenEvent {}
