part of 'finish_profile_bloc.dart';

sealed class FinishProfileState extends Equatable {
  const FinishProfileState();

  @override
  List<Object> get props => [];
}

final class FinishProfileInitial extends FinishProfileState {}

final class FinishProfileSuccess extends FinishProfileState {
  final UserModelEntity userModel;
  const FinishProfileSuccess({required this.userModel});
}

final class FinishProfileLoading extends FinishProfileState {}

final class FinishProfileError extends FinishProfileState {
  final String msg;
  const FinishProfileError({required this.msg});
}
