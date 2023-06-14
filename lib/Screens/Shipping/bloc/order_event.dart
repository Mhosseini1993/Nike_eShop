part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class CreateOrder extends OrderEvent{
  final RequestAddOrderDto orderDto;
  CreateOrder(this.orderDto);
}
