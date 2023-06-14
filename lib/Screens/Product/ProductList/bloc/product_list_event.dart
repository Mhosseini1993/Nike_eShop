part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}


class ProductListStarted extends ProductListEvent{
  final int sortType;
  ProductListStarted(this.sortType);
}