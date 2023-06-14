import 'package:dio/dio.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Order/OrderHistory.dart';
import 'package:nike/Data/Models/Order/RequestAddOrderDto.dart';
import 'package:nike/Data/Models/Order/ResultAddOrderDto.dart';
import 'package:nike/Data/Source/Order/IOrderDataSource.dart';

class RemoteOrderDataSource
    with HttpResponseValidator
    implements IOrderDataSource {
  Dio httpContext;

  RemoteOrderDataSource(this.httpContext);

  @override
  Future<ResultAddOrderDto> AddNewOrder(RequestAddOrderDto order) async {
    Response response =
        await httpContext.post('/order/submit', data: order.toJson());
    validateResponse(response);
    return ResultAddOrderDto.fromJson(response.data);
  }

  @override
  Future<ResultOrderHistoryDto> GetOrderHistories() async {
    Response response = await httpContext.get('/order/list');
    ResultOrderHistoryDto result =
        ResultOrderHistoryDto.fromJson(response.data);
    validateResponse(response);
    return ResultOrderHistoryDto.fromJson(response.data);
  }
}
