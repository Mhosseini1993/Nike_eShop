import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Baner/Baner.dart';
import 'package:nike/Data/Source/Baner/IBanerDataSource.dart';

import '../../Models/Order/OrderHistory.dart';

class RemoteBanerDataSource with HttpResponseValidator implements IBanerDataSource {
  final Dio _httpContext;
  RemoteBanerDataSource(this._httpContext);
  @override
  Future<List<Baner>> getAll() async {
    Response response = await _httpContext.get('/banner/slider');
    List<Baner> baners = [];
    validateResponse(response);
    if (response.data is List<dynamic>) {
      for (var value in (response.data as List<dynamic>)) {
        baners.add(Baner.fromJson(value));
      }
      return baners;
    } else {
      return baners;
    }
  }
}
