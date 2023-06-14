import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Baner/Baner.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Models/Product/ProductSortType.dart';
import 'package:nike/Data/Repos/Baner/IBanerRepository.dart';
import 'package:nike/Data/Repos/Product/IProductRepository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBanerRepository _banerRepository;
  final IProductRepository _productRepository;

  HomeBloc(this._banerRepository, this._productRepository)
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefreshed) {
        try {
          emit(HomeLoading());
          await Future.delayed(const Duration(seconds: 1));
          List<Baner> baners = await _banerRepository.getAll();
          List<Product> latestProducts =
              await _productRepository.getAll(ProductSortType.Latest);
          List<Product> popularProducts =
              await _productRepository.getAll(ProductSortType.Popular);
          emit(HomeSuccess(
              baners: baners,
              latestProducts: latestProducts,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
//
