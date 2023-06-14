import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/AuthResultDto.dart';
import 'package:nike/Data/Models/Order/OrderHistory.dart';
import 'package:nike/Data/Source/Auth/IAuthDataSource.dart';

class RemoteAuthDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio _httpContext;

  RemoteAuthDataSource(this._httpContext);

  @override
  Future<AuthResultDto> SignIn(String email, String password) async {
    Response response = await _httpContext.post(
      '/auth/token',
      data: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": CNT_CLIENT_SECRET,
        "username": email,
        "password": password,
      },
    );
    validateResponse(response);


    return AuthResultDto(
        access_token: response.data['access_token'],
        refresh_token: response.data['refresh_token'],
        error: '',
        message: '',
        email: email);
  }

  @override
  Future<AuthResultDto> RefreshToken(String refreshToken) async {
    Response response = await _httpContext.post(
      '/auth/token',
      data: {
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
        "client_id": 2,
        "client_secret": CNT_CLIENT_SECRET
      },
    );
    validateResponse(response);
    return AuthResultDto(
        access_token: response.data['access_token'],
        refresh_token: response.data['refresh_token'],
        error: '',
        message: '',
        email: '');
  }

  @override
  Future<AuthResultDto> SignUp(String email, String password) async {
    Response response = await _httpContext.post(
      '/user/register',
      data: {"email": email, "password": password},
    );
    validateResponse(response);
    return SignIn(email, password);
  }
}
