import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lite_jobs/core/res/user_model.dart';

part 'finish_profile_event.dart';
part 'finish_profile_state.dart';

class FinishProfileBloc extends Bloc<FinishProfileEvent, FinishProfileState> {
  FinishProfileBloc() : super(FinishProfileInitial()) {
    on<UpdateUserDataEvent>((event, emit) {});
  }
}
