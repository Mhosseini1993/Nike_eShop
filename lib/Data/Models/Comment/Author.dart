class Author{
  final String email;
  Author.fromJson(Map<String,dynamic> json):email=json['email'];
}