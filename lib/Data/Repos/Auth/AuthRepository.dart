import 'package:flutter/cupertino.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/AuthResultDto.dart';
import 'package:nike/Data/Repos/Auth/IAuthRepository.dart';
import 'package:nike/Data/Source/Auth/IAuthDataSource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource _remoteDataSource;
  static ValueNotifier<AuthResultDto?> authChangeNotifier =
      ValueNotifier<AuthResultDto?>(null);

  AuthRepository(this._remoteDataSource);

  @override
  Future<void> SignIn(String email, String password) async {
    AuthResultDto authResult = await _remoteDataSource.SignIn(email, password);
    _PersistToken(authResult);
  }

  @override
  Future<void> SignUp(String email, String password) async {
    AuthResultDto authResult = await _remoteDataSource.SignUp(email, password);
    _PersistToken(authResult);
  }

  Future<void> SingOut() async {
    authChangeNotifier.value = null;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(CNT_ACCESS_TOKEN);
    await preferences.remove(CNT_REFRESH_TOKEN);
  }

  @override
  Future<void> RefreshToken(String refreshToken) async {
    AuthResultDto authResult =
        await _remoteDataSource.RefreshToken(refreshToken);
    _PersistToken(authResult);
  }

  Future<void> _PersistToken(AuthResultDto authResult) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(CNT_ACCESS_TOKEN, authResult.access_token!);
    preferences.setString(CNT_REFRESH_TOKEN, authResult.refresh_token!);
    preferences.setString(CNT_USER_EMAIL, authResult.email!);
    _LoadAuthToken();
  }

  Future<void> _LoadAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessToken = '';
    String refreshToken = '';
    String email = '';
    accessToken = preferences.getString(CNT_ACCESS_TOKEN) ?? '';
    refreshToken = preferences.getString(CNT_REFRESH_TOKEN) ?? '';
    email = preferences.getString(CNT_USER_EMAIL) ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthResultDto(
          access_token: accessToken,
          refresh_token: refreshToken,
          message: '',
          error: '',
          email: email);
    }
  }
}
