import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Order/RequestAddOrderDto.dart';
import 'package:nike/Data/Models/Order/ResultAddOrderDto.dart';
import 'package:nike/Data/Repos/Order/IOrderReposiotry.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is CreateOrder) {
        try {
          emit(OrderLoading());
          await Future.delayed(const Duration(seconds: 2));
          ResultAddOrderDto result= await _orderRepository.AddNewOrder(event.orderDto);
          emit(OrderSuccess(result));
        } catch (e) {
          emit(OrderError(
              (e is AppException) ? e : AppException(message: e.toString())));
        }
      }
    });
  }
}
