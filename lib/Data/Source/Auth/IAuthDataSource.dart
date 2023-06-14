import 'package:nike/Data/Models/AuthResultDto.dart';

abstract class IAuthDataSource{
  Future<AuthResultDto> SignIn(String email,String password);
  Future<AuthResultDto> SignUp(String email,String password);
  Future<AuthResultDto> RefreshToken(String refreshToken);
}

