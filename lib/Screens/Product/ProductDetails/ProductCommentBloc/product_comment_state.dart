part of 'product_comment_bloc.dart';

@immutable
abstract class ProductCommentState {}

class ProductCommentLoading extends ProductCommentState {}

class ProductCommentError extends ProductCommentState{
  final AppException exception;
  ProductCommentError(this.exception);
}

class ProductCommentSuccess extends ProductCommentState{
  final List<Comment> comments;
  ProductCommentSuccess(this.comments);
}