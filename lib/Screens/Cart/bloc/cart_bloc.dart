import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/AuthResultDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartListDto.dart';
import 'package:nike/Data/Repos/Cart/ICartRepository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is CartStarted) {
          if (event.authResultDto == null ||
              event.authResultDto!.access_token!.isEmpty) {
            emit(CartAuthRequired());
          } else {
            await _loadCartItems(emit, event.isRefreshing);
          }
        }
        else if (event is CartAuthInfoChanged) {
          if (event.authResultDto == null ||
              event.authResultDto!.access_token!.isEmpty) {
            //کاربر ار حساب کاربری خودش خارج شده است
            emit(CartAuthRequired());
          } else {
            //در غیر این صورت یعنی توکن دارد
            if (state is CartAuthRequired) {
              await _loadCartItems(emit, false);
            }
          }
        }
        else if (event is CartDeleteButtonClicked) {
          final CartSuccess res = (state as CartSuccess);
          int index = res.cartListDto.cart_items.indexWhere(
              (element) => element.cart_item_id == event.cartItemId);
          res.cartListDto.cart_items.elementAt(index).deleteButtonLoading =
              true;
          emit(CartSuccess(res.cartListDto));

          await Future.delayed(const Duration(seconds: 2));
          await _cartRepository.RemoveFromCart(event.cartItemId);

          final CartSuccess successState = (state as CartSuccess);
          successState.cartListDto.cart_items.removeWhere(
              (element) => element.cart_item_id == event.cartItemId);
          if (successState.cartListDto.cart_items.isEmpty) {
            emit(CartEmpty());
          } else {
            emit(CartSuccess(updateCartPriceInfo(successState.cartListDto)));
          }
        }
        else if (event is ChangeItemCountButtomClicked) {

          CartSuccess cartSuccess = (state as CartSuccess);
          int index = cartSuccess.cartListDto.cart_items.indexWhere((element) => element.cart_item_id == event.cartItemId);
          cartSuccess.cartListDto.cart_items.elementAt(index).changeCountLoading=true;
          emit(CartSuccess(cartSuccess.cartListDto));
          await Future.delayed(const Duration(seconds: 2));
          await _cartRepository.ChangeCount(event.cartItemId, event.count);
          cartSuccess.cartListDto.cart_items.elementAt(index)
            ..count = event.count
            ..changeCountLoading=false;
          emit(CartSuccess(updateCartPriceInfo(cartSuccess.cartListDto)));
        }
        else {
          throw Exception('event not Defined');
        }
      } catch (e) {
        emit(CartError((e is AppException) ? e : AppException()));
      }
    });
  }

  ResultCartListDto updateCartPriceInfo(ResultCartListDto requestDto) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingCost = 0;
    for (var item in requestDto.cart_items) {
      totalPrice += item.product.previous_price * item.count;
      payablePrice += item.product.price * item.count;
    }
    shippingCost = payablePrice >= 250000 ? 0 : 30000;

    requestDto.total_price = totalPrice;
    requestDto.payable_price = payablePrice;
    requestDto.shipping_cost = shippingCost;
    return requestDto;
  }

  Future<void> _loadCartItems(Emitter<CartState> emit, bool isRefresh) async {
    if (!isRefresh) emit(CartLoading());
    await Future.delayed(const Duration(seconds: 2));
    ResultCartListDto result = await _cartRepository.GetCartList();
    if (result.cart_items.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartSuccess(result));
    }
  }
}
