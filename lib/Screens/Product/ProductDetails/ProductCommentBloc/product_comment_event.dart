part of 'product_comment_bloc.dart';

@immutable
abstract class ProductCommentEvent {}

class ProductCommentStarted extends ProductCommentEvent{
}

class ProductCommentRefreshed extends ProductCommentEvent{

}