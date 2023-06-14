import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Source/FavoriteProduct/IFavoriteProductDataSource.dart';

class HiveFavoriteProductDataSource implements IFavoriteProductDataSource {
  final Box<Product> _box;

  HiveFavoriteProductDataSource(this._box);

  @override
  Future<void> AddToGavorite(Product product) async {
    await _box.put(product.id, product);
  }

  @override
  bool IsFavorite(Product product)  {
    return _box.containsKey(product.id);
  }

  @override
  Future<void> RemoveFromGavorite(Product product) async {
    await _box.delete(product.id);
  }

  @override
  List<Product> GetFavorites() {
    return _box.values.toList();
  }
}
