part of 'receipt_bloc.dart';

@immutable
abstract class ReceiptState {}

class ReceiptLoading extends ReceiptState {}

class ReceiptSuccess extends ReceiptState{
  final ResultReceiptDto receiptDto;
  ReceiptSuccess(this.receiptDto);
}

class ReceiptError extends ReceiptState{
  final AppException exception;
  ReceiptError(this.exception);
}