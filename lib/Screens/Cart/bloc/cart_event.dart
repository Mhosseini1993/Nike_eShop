part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartStarted extends CartEvent {
  final AuthResultDto? authResultDto;
  final bool isRefreshing;
  CartStarted(this.authResultDto,{this.isRefreshing=false});
}

class CartAuthInfoChanged extends CartEvent{
  final AuthResultDto? authResultDto;
  CartAuthInfoChanged(this.authResultDto);
}

class CartDeleteButtonClicked extends CartEvent{
  final int cartItemId;
  CartDeleteButtonClicked(this.cartItemId);
}

class ChangeItemCountButtomClicked extends CartEvent {
  final int count;
  final int cartItemId;
  ChangeItemCountButtomClicked(this.count, this.cartItemId);
}