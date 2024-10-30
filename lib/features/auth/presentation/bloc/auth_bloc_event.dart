part of 'auth_bloc.dart';

sealed class AuthBlocEvent {}

final class SignUpEvent extends AuthBlocEvent {
  final bool isGoogleSignin;
  final String address;
  final String name;
  final String email;
  final String phone;
  final String password;

  final Uint8List? fetchImage;

  SignUpEvent(
      {required this.address,
      required this.email,
      required this.fetchImage,
      required this.isGoogleSignin,
      required this.name,
      required this.password,
      required this.phone});
}

final class SignUpImageFetching extends AuthBlocEvent {
  Uint8List? image;
  SignUpImageFetching({this.image});
}

final class SingUpBackButton extends AuthBlocEvent {}

final class InitAuthInitial extends AuthBlocEvent {}

final class SignInEvent extends AuthBlocEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
}

final class ForgotPasswordEvent extends AuthBlocEvent {}
