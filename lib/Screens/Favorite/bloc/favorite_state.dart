part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState{
  final List<Product> products;
  FavoriteSuccess(this.products);
}
class FavoriteError extends FavoriteState{
  final String message;
  FavoriteError(this.message);
}

class FavoriteEmpty extends FavoriteState{
}