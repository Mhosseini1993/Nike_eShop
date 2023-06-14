
import 'package:nike/Data/Models/Product/Product.dart';

abstract class IFavoriteProductDataSource{
  Future<void> AddToGavorite(Product product);
  Future<void> RemoveFromGavorite(Product product);
  bool IsFavorite(Product product);
  List<Product> GetFavorites();
}