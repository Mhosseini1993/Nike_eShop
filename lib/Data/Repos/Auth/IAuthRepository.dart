import 'package:nike/Data/Models/AuthResultDto.dart';

abstract class IAuthRepository {
  Future<void> SignIn(String email, String password);
  Future<void> SignUp(String email, String password);
  Future<void> RefreshToken(String refreshToken);
  Future<void> SingOut();
}


