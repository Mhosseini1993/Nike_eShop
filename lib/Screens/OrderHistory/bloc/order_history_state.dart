part of 'order_history_bloc.dart';

@immutable
abstract class OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistorySuccess extends OrderHistoryState {
  final ResultOrderHistoryDto orderHistoryDto;

  OrderHistorySuccess(this.orderHistoryDto);
}

class OrderHistoryEmpty extends OrderHistoryState{

}
class OrderHistoryError extends OrderHistoryState {
  final AppException exception;

  OrderHistoryError(this.exception);
}


