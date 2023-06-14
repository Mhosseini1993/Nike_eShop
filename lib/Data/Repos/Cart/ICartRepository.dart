import 'package:nike/Data/Models/Cart/ResultAddToCartDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartChangeCountDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartListDto.dart';

abstract class ICartRepository{
  Future<ResultAddToCartDto> AddToCart(int productId);
  Future<void> RemoveFromCart(int cartItemId);
  Future<ResultCartChangeCountDto> ChangeCount(int cartItemId,int count);
  Future<int> GetCount();
  Future<ResultCartListDto> GetCartList();
}
