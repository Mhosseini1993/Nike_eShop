import 'package:nike/Data/Models/Product/Product.dart';

abstract class IProductDataSource{
  Future<List<Product>> getAll(int sortType);
  Future<List<Product>> search(String searchTerm);
}