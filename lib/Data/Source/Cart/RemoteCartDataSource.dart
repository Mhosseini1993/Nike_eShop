import 'package:dio/dio.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Cart/ResultAddToCartDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartChangeCountDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartListDto.dart';
import 'ICartDataSource.dart';

class RemoteCartDataSource
    with HttpResponseValidator
    implements ICartDataSource {

  Dio _httpContext;

  RemoteCartDataSource(this._httpContext);

  @override
  Future<ResultAddToCartDto> AddToCart(int productId) async {
    Response response = await _httpContext.post('/cart/add', data: {
      "product_id": productId,
    });
    validateResponse(response);
    return ResultAddToCartDto.fromJson(response.data);
  }

  @override
  Future<ResultCartChangeCountDto> ChangeCount(int cartItemId,
      int count) async {
    Response response = await _httpContext.post('/cart/changeCount', data: {
      "cart_item_id": cartItemId,
      "count": count,
    });
    validateResponse(response);
    return ResultCartChangeCountDto.fromJson(response.data);
  }

  @override
  Future<ResultCartListDto> GetCartList() async {
    Response response = await _httpContext.get('/cart/list');
    validateResponse(response);

    return ResultCartListDto.fromJson(response.data);
  }

  @override
  Future<void> RemoveFromCart(int cartItemId) async {
    Response response = await _httpContext.post('/cart/remove', data: {
      "cart_item_id": cartItemId,
    });
    validateResponse(response);
  }

  @override
  Future<int> GetCount() async {
    Response response = await _httpContext.get('/cart/count');
    validateResponse(response);
    return (response.data['count']);
  }
}
