import 'package:nike/Data/Models/Order/OrderHistory.dart';
import 'package:nike/Data/Models/Order/RequestAddOrderDto.dart';
import 'package:nike/Data/Models/Order/ResultAddOrderDto.dart';
import 'package:nike/Data/Repos/Order/IOrderReposiotry.dart';
import 'package:nike/Data/Source/Order/IOrderDataSource.dart';

class OrderRepository implements IOrderRepository {
  final IOrderDataSource _remoteDataSource;
  OrderRepository(this._remoteDataSource);
  @override
  Future<ResultAddOrderDto> AddNewOrder(RequestAddOrderDto order) => _remoteDataSource.AddNewOrder(order);

  @override
  Future<ResultOrderHistoryDto> GetOrderHistories() => _remoteDataSource.GetOrderHistories();
}
