import 'package:hive_flutter/adapters.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Repos/Product/IProductRepository.dart';
import 'package:nike/Data/Source/Product/IProductDataSource.dart';


class ProductRepository implements IProductRepository {
  final IProductDataSource _remoteDataSource;
  ProductRepository(this._remoteDataSource);

  @override
  Future<List<Product>> getAll(int sortType) =>
      _remoteDataSource.getAll(sortType);

  @override
  Future<List<Product>> search(String searchTerm) =>
      _remoteDataSource.search(searchTerm);

}
