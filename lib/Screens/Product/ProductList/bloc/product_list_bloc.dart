import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Repos/Product/IProductRepository.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository _productRepository;

  ProductListBloc(this._productRepository) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        try {
          emit(ProductListLoading());
          await Future.delayed(const Duration(seconds: 2));
          List<Product> products =
              await _productRepository.getAll(event.sortType);
          emit(ProductListSuccess(products,event.sortType));
        } catch (e) {
          emit(ProductListError(
              (e is AppException) ? e : AppException(message: e.toString())));
        }
      }
    });
  }
}
