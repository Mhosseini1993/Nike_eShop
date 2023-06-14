part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;

  HomeError({required this.exception});
}

class HomeSuccess extends HomeState {
  final List<Baner> baners;
  final List<Product> latestProducts;
  final List<Product> popularProducts;

  HomeSuccess({
    required this.baners,
    required this.latestProducts,
    required this.popularProducts,
  });
}
