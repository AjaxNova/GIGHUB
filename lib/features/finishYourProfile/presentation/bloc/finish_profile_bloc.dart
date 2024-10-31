import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/finishYourProfile/domain/useCase/finish_profile_usecase.dart';

part 'finish_profile_event.dart';
part 'finish_profile_state.dart';

class FinishProfileBloc extends Bloc<FinishProfileEvent, FinishProfileState> {
  FinishProfileUsecase finishProfileUsecase;
  FinishProfileBloc(this.finishProfileUsecase) : super(FinishProfileInitial()) {
    on<UpdateUserDataEvent>((event, emit) async {
      try {
        final data = await finishProfileUsecase.call(
            params: FinishProfileParams(event.qualification, event.uid,
                event.age, event.gender, event.skill, event.bio));
        if (data is DataSuccess) {
          emit(FinishProfileSuccess(userModel: data.data!));
        } else {
          emit(FinishProfileError(msg: data.error!));
        }
      } catch (e) {
        emit(FinishProfileError(msg: e.toString()));
      }
    });
  }
}
