part of 'finish_profile_bloc.dart';

sealed class FinishProfileEvent extends Equatable {
  const FinishProfileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserDataEvent extends FinishProfileEvent {}
