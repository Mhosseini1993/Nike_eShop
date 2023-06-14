import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Repos/FavoriteProduct/IFavoriteProductRepository.dart';
import 'package:nike/Data/Source/FavoriteProduct/IFavoriteProductDataSource.dart';

class FavoriteProductRepository implements IFavoriteProductRepository {
  final IFavoriteProductDataSource _hive;
  FavoriteProductRepository(this._hive);

  @override
  Future<void> AddToGavorite(Product product) => _hive.AddToGavorite(product);

  @override
  bool IsFavorite(Product product) {
    return _hive.IsFavorite(product);
  }

  @override
  Future<void> RemoveFromGavorite(Product product) =>
      _hive.RemoveFromGavorite(product);

  @override
  List<Product> GetFavorites() => _hive.GetFavorites();
}
