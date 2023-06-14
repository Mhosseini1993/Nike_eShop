part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState{
  final ResultCartListDto cartListDto;
  CartSuccess(this.cartListDto);
}

class CartError extends CartState{
  final AppException exception;
  CartError(this.exception);
}

class CartAuthRequired extends CartState{
}

class CartEmpty extends CartState{
}