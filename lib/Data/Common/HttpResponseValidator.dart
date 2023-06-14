import 'package:dio/dio.dart';
import 'package:nike/Data/Common/AppException.dart';

mixin HttpResponseValidator{
  void validateResponse(Response response) {
    if (response.statusCode != 200) throw AppException();
  }
}