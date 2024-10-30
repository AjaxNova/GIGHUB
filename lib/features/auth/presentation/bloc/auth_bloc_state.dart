part of 'auth_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

////////////////////////////////////////////////////
///
final class SignUpInitial extends AuthBlocState {}

final class SignUpLoadingState extends AuthBlocState {}

final class SignUpSuccessState extends AuthBlocState {
  final UserModelEntity userModel;
  SignUpSuccessState({required this.userModel});
}

final class SignUpFailedState extends AuthBlocState {
  final String msg;
  final Uint8List file;
  SignUpFailedState({required this.msg, required this.file});
}

final class SignUpImageLoadingState extends AuthBlocState {}

final class SignUpImageFetchedState extends AuthBlocState {
  final Uint8List image;
  SignUpImageFetchedState({required this.image});
}

final class SignUpImageErrorState extends AuthBlocState {
  final String text;
  SignUpImageErrorState({required this.text});
}

/////////////////////////////////////////////////////

final class SignInLoadingState extends AuthBlocState {}

final class SignInSuccessState extends AuthBlocState {
  final UserModelEntity userModel;
  SignInSuccessState({required this.userModel});
}

final class SignInFailedState extends AuthBlocState {
  final String msg;
  SignInFailedState({required this.msg});
}

///////////////////////////////////////////////////////
final class ForgotPassLoadingState extends AuthBlocState {}

final class ForgotPassSuccessState extends AuthBlocState {}

final class ForgotPassFailedState extends AuthBlocState {}
