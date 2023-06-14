part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderSuccess extends OrderState {
  final ResultAddOrderDto result;
  OrderSuccess(this.result);
}

class OrderError extends OrderState {
  final AppException exception;

  OrderError(this.exception);
}

class OrderLoading extends OrderState {}
