import 'package:dio/dio.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Source/Product/IProductDataSource.dart';

class RemoteProductDataSource with HttpResponseValidator implements IProductDataSource {
  final Dio _httpContext;

  RemoteProductDataSource(this._httpContext);

  @override
  Future<List<Product>> getAll(int sortType) async {
    Response response = await _httpContext.get('/product/list?sort=$sortType');
    validateResponse(response);
    List<Product> products = [];
    if (response.data is List<dynamic>) {
      for (var value in (response.data as List<dynamic>)) {
        products.add(Product.fromJson(value));
      }
      return products;
    } else {
      return products;
    }
  }

  @override
  Future<List<Product>> search(String searchTerm) async {
    Response response = await _httpContext.get('/product/search?q=$searchTerm');
    validateResponse(response);
    List<Product> products = [];
    if (response.data is List<dynamic>) {
      for (var value in (response.data as List<dynamic>)) {
        products.add(Product.fromJson(value));
      }
      return products;
    } else {
      return products;
    }
  }
}
