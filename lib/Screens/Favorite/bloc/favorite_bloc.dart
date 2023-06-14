import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Repos/FavoriteProduct/IFavoriteProductRepository.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final IFavoriteProductRepository _repository;

  FavoriteBloc(this._repository) : super(FavoriteLoading()) {
    on<FavoriteEvent>((event, emit) async {
      try {
        if (event is FavoriteStarted) {
          if (!event.isRefreshing) {
            emit(FavoriteLoading());
            await Future.delayed(const Duration(seconds: 2));
          }
          List<Product> lstProducts = _repository.GetFavorites();
          if (lstProducts.isEmpty) {
            emit(FavoriteEmpty());
          } else {
            emit(FavoriteSuccess(lstProducts));
          }
        } else if (event is FavoriteRemove) {
          final FavoriteSuccess res = (state as FavoriteSuccess);
          int index = res.products.indexOf(event.product);
          res.products.elementAt(index).isDeleting = true;
          emit(FavoriteSuccess(res.products));
          await Future.delayed(const Duration(seconds: 2));
          await _repository.RemoveFromGavorite(event.product);
          final FavoriteSuccess successState = (state as FavoriteSuccess);
          successState.products.remove(event.product);
          if (successState.products.isEmpty) {
            emit(FavoriteEmpty());
          } else {
            emit(FavoriteSuccess(successState.products));
          }
        }
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });
  }
}
