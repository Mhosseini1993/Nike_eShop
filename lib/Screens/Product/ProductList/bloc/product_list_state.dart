part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState{
  final List<Product> products;
  final int sortType;
  ProductListSuccess(this.products, this.sortType);
}

class ProductListError extends ProductListState{
  final AppException exception;
  ProductListError(this.exception);
}
