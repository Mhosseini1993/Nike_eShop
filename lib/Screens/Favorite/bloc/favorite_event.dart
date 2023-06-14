part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteStarted extends FavoriteEvent {
  final bool isRefreshing;

  FavoriteStarted({this.isRefreshing = false});
}

class FavoriteRemove extends FavoriteEvent {
  final Product product;

  FavoriteRemove(this.product);
}
