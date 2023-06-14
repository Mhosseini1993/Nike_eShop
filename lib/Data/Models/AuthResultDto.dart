class AuthResultDto {
  final String? error;
  final String? message;
  final String? access_token;
  final String? refresh_token;
  final String? email;

  AuthResultDto({required this.error,
      required this.message,
      required this.access_token,
      required this.refresh_token,
      required this.email});

  AuthResultDto.fromJson(Map<String, dynamic> json)
      : error = json['error'] ?? '',
        message = json['message'] ?? '',
        access_token = json['access_token'] ?? '',
        refresh_token = json['refresh_token'] ?? '',
        email = '';
}
