import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Receipt/ResultReceiptDto.dart';
import 'package:nike/Data/Source/Receipt/IReceiptDataSource.dart';

class RemoteReceiptDataSource
    with HttpResponseValidator
    implements IReceiptDataSource {
  Dio httpContext;

  RemoteReceiptDataSource(this.httpContext);
  @override
  Future<ResultReceiptDto> GetReceipt(int orderId) async {
    Response response = await httpContext.get('/order/checkout?order_id=$orderId');
    validateResponse(response);
    return ResultReceiptDto.fromJson(response.data);
  }
}
