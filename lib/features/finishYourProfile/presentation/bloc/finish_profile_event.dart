part of 'finish_profile_bloc.dart';

sealed class FinishProfileEvent extends Equatable {
  const FinishProfileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserDataEvent extends FinishProfileEvent {
  final String qualification;
  final String uid;
  final String age;
  final String gender;
  final List<String> skill;
  final String bio;

  const UpdateUserDataEvent(
      {required this.bio,
      required this.qualification,
      required this.uid,
      required this.age,
      required this.gender,
      required this.skill});
}
