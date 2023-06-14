part of 'receipt_bloc.dart';

@immutable
abstract class ReceiptEvent {}

class ReceiptStarted extends ReceiptEvent{
  final int orderId;
  ReceiptStarted(this.orderId);
}