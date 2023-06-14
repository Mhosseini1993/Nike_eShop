import 'package:nike/Data/Models/Comment/Author.dart';

class Comment {
  final int id;
  final String title;
  final String content;
  final String date;
  final Author author;

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        author = Author.fromJson(json['author']);
}
