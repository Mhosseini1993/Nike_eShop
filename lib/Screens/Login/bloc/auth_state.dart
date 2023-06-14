part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final AuthScreenMode screenMode;
  AuthState(this.screenMode);
}

class AuthInitial extends AuthState {
  AuthInitial(AuthScreenMode screenMode):super(screenMode);
}

class AuthLoading extends AuthState {
  AuthLoading(AuthScreenMode screenMode):super(screenMode);
}

class AuthError extends AuthState {
  final AppException exception;
  AuthError(this.exception, AuthScreenMode screenMode) : super(screenMode);
}

class AuthSucess extends AuthState {
  AuthSucess(AuthScreenMode screenMode):super(screenMode);
}
