import 'package:nike/Data/Models/Product/Product.dart';

abstract class IProductRepository{
  Future<List<Product>> getAll(int sortType);
  Future<List<Product>> search(String searchTerm);
}
