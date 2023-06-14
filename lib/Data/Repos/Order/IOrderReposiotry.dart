import 'package:nike/Data/Models/Order/OrderHistory.dart';
import 'package:nike/Data/Models/Order/RequestAddOrderDto.dart';
import 'package:nike/Data/Models/Order/ResultAddOrderDto.dart';

abstract class IOrderRepository {
  Future<ResultAddOrderDto> AddNewOrder(RequestAddOrderDto order);

  Future<ResultOrderHistoryDto> GetOrderHistories();
}
