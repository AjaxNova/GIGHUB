part of 'finish_profile_bloc.dart';

sealed class FinishProfileState extends Equatable {
  const FinishProfileState();

  @override
  List<Object> get props => [];
}

final class FinishProfileInitial extends FinishProfileState {}

final class FinishProfileSuccess extends FinishProfileEvent {
  final UserModelGlobal userModel;
  const FinishProfileSuccess({required this.userModel});
}

final class FinishProfileLoading extends FinishProfileEvent {}
