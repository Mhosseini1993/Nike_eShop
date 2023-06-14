import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Order/OrderHistory.dart';
import 'package:nike/Data/Repos/Order/IOrderReposiotry.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository _orderRepository;

  OrderHistoryBloc(this._orderRepository) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      try {
        if (event is OrderHistoryStarted) {
          emit(OrderHistoryLoading());
          await Future.delayed(const Duration(seconds: 2));
          ResultOrderHistoryDto result = await _orderRepository.GetOrderHistories();
          if (result.OrderItems.isEmpty) {
            emit(OrderHistorySuccess(result));
          } else {
            emit(OrderHistoryEmpty());
          }
        }
      } catch (e) {
        emit(OrderHistoryError(
            (e is AppException) ? e : AppException(message: e.toString())));
      }
    });
  }
}
