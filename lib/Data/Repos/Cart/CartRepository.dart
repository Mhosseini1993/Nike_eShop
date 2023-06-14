import 'package:flutter/cupertino.dart';
import 'package:nike/Data/Models/Cart/ResultAddToCartDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartChangeCountDto.dart';
import 'package:nike/Data/Models/Cart/ResultCartListDto.dart';
import 'package:nike/Data/Repos/Cart/ICartRepository.dart';
import 'package:nike/Data/Source/Cart/ICartDataSource.dart';

class CartRepository implements ICartRepository {
  final ICartDataSource _remoteDataSource;
  static ValueNotifier<int> cartItemCountNotifier = ValueNotifier<int>(0);

  CartRepository(this._remoteDataSource);

  @override
  Future<ResultAddToCartDto> AddToCart(int productId) async {
    ResultAddToCartDto result = await _remoteDataSource.AddToCart(productId);
    await GetCount();
    return result;
  }

  @override
  Future<ResultCartChangeCountDto> ChangeCount(
      int cartItemId, int count) async {
    ResultCartChangeCountDto result =
        await _remoteDataSource.ChangeCount(cartItemId, count);
    await GetCount();
    return result;
  }

  @override
  Future<ResultCartListDto> GetCartList() => _remoteDataSource.GetCartList();

  @override
  Future<void> RemoveFromCart(int cartItemId) async {
    await _remoteDataSource.RemoveFromCart(cartItemId);
    await GetCount();
  }

  @override
  Future<int> GetCount() async {
    int count = await _remoteDataSource.GetCount();
    cartItemCountNotifier.value = count;
    return count;
  }
}
