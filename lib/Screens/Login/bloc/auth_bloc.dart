import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Common/Enums.dart';
import 'package:nike/Data/Repos/Auth/IAuthRepository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository;
  AuthScreenMode screenMode;

  AuthBloc(this._repository, this.screenMode)
      : super(AuthInitial(screenMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonClicked) {
          emit(AuthLoading(screenMode));
           await Future.delayed(const Duration(seconds: 2));
          if (screenMode == AuthScreenMode.SIGNIN) {
            await _repository.SignIn(event.email, event.password);
            emit(AuthSucess(screenMode));
          } else if (screenMode == AuthScreenMode.SIGNUP) {
            await _repository.SignUp(event.email, event.password);
            emit(AuthSucess(screenMode));
          }
        } else if (event is AuthModeChanged) {
          if (screenMode == AuthScreenMode.SIGNIN) {
            screenMode = AuthScreenMode.SIGNUP;
          } else {
            screenMode = AuthScreenMode.SIGNIN;
          }
          emit(AuthInitial(screenMode));
        }
      } catch (e) {
        emit(AuthError(e is AppException ? e : AppException(),
            screenMode));
      }
    });
  }
}
