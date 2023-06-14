part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthButtonClicked extends AuthEvent {
  final String email;
  final String password;
  AuthButtonClicked(this.email, this.password);
}
class AuthModeChanged extends AuthEvent {}


