part of 'init_cart_bloc.dart';

@immutable
abstract class InitCartEvent {}

class AddToCartButtonClicked extends InitCartEvent{
  final int productId;
  AddToCartButtonClicked(this.productId) ;
}