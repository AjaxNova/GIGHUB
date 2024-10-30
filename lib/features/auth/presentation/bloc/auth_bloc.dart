import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_jobs/core/functions/get_storage_perm.dart';
import 'package:lite_jobs/core/res/data_state.dart';
import 'package:lite_jobs/features/auth/domain/entities/user_model_entity.dart';
import 'package:lite_jobs/features/auth/domain/useCases/sign_in.dart';
import 'package:lite_jobs/features/auth/domain/useCases/sign_up.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  AuthBloc(this._signUpUseCase, this._signInUseCase)
      : super(AuthBlocInitial()) {
    on<InitAuthInitial>(
      (event, emit) => emit(AuthBlocInitial()),
    );
    on<SignUpEvent>(_onSignUpEvent);
    on<SignUpImageFetching>(_fetchImage);
    on<SingUpBackButton>(_onBackButtonSignUp);
    //---------------------------------------------//
    on<SignInEvent>(_onLogIn);
  }

  _onLogIn(SignInEvent event, Emitter<AuthBlocState> emit) async {
    emit(SignInLoadingState());
    final dataState = await _signInUseCase(
        params: SignInUseCaseparams(
      email: event.email,
      password: event.password,
    ));
    if (dataState is DataSuccess && dataState.data != null) {
      emit(SignInSuccessState(userModel: dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(SignInFailedState(msg: dataState.error!));
    }
  }

/////////////signUp functions////////////////////
  _onSignUpEvent(SignUpEvent event, Emitter<AuthBlocState> emit) async {
    emit(SignUpLoadingState());
    final dataState = await _signUpUseCase(
        params: SignUpUseCaseparams(
      name: event.name,
      email: event.email,
      phone: event.phone,
      password: event.password,
      address: event.address,
      file: event.fetchImage!,
    ));

    if (dataState is DataSuccess && dataState.data != null) {
      emit(SignUpSuccessState(userModel: dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(SignUpFailedState(msg: dataState.error!, file: event.fetchImage!));
    }
  }
}

_onBackButtonSignUp(SingUpBackButton event, Emitter<AuthBlocState> emit) {
  emit(AuthBlocInitial());
}

fetchImage(ImageSource source) async {
  try {
    return getStoragePermission(source);
  } catch (e) {
    throw Exception(e);
  }
}

_fetchImage(SignUpImageFetching event, Emitter<AuthBlocState> emit) async {
  emit(SignUpImageLoadingState());
  try {
    final file = await fetchImage(ImageSource.gallery);

    if (file != null) {
      emit(SignUpImageFetchedState(image: file));
    } else if (event.image != null) {
      emit(SignUpImageFetchedState(image: event.image!));
    } else {
      emit(AuthBlocInitial());
    }
  } catch (e) {
    emit(SignUpImageErrorState(text: e.toString()));
  }
}
