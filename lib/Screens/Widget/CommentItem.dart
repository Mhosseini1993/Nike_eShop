import 'package:flutter/material.dart';
import 'package:nike/Data/Models/Comment/Comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme=Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.title),
                      const SizedBox(height: 4,),
                      Text(comment.author.email,style: theme.textTheme.caption,),
                    ],
                  ),
                  Text(comment.date,style: theme.textTheme.caption,),
                ],
              ),
              const SizedBox(height: 16,),
              Text(comment.content,style: TextStyle(height: 1.4),)
            ],
          ),
        ),
      ),
    );
  }
}
