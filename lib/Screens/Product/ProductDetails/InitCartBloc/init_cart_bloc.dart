import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Repos/Cart/ICartRepository.dart';

part 'init_cart_event.dart';
part 'init_cart_state.dart';

class InitCartBloc extends Bloc<InitCartEvent, InitCartState> {
  final ICartRepository _repository;

  InitCartBloc(this._repository) : super(InitCartInitial()) {
    on<InitCartEvent>((event, emit) async {
      try {
        if (event is AddToCartButtonClicked) {
          emit(InitCartLoading());
          await Future.delayed(const Duration(seconds: 2));
          var res = await _repository.AddToCart(event.productId);
          emit(InitCartSuccess());
        }
      } catch (e) {
        emit(InitCartError((e is AppException) ? e : AppException()));
      }
    });
  }
}
