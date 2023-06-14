part of 'init_cart_bloc.dart';

@immutable
abstract class InitCartState {}

class InitCartInitial extends InitCartState {}

class InitCartLoading extends InitCartState {}

class InitCartSuccess extends InitCartState {}

class InitCartError extends InitCartState {
  final AppException exception;
  InitCartError(this.exception);
}
