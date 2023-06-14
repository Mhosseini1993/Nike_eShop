import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Comment/Comment.dart';
import 'package:nike/Data/Repos/Comment/ICommentRepository.dart';

part 'product_comment_event.dart';

part 'product_comment_state.dart';

class ProductCommentBloc
    extends Bloc<ProductCommentEvent, ProductCommentState> {
  final ICommentRepository _repository;
  final int _productId;

  ProductCommentBloc(this._repository, this._productId)
      : super(ProductCommentLoading()) {
    on<ProductCommentEvent>((event, emit) async {
      if (event is ProductCommentStarted || event is ProductCommentRefreshed) {
        try {
          emit(ProductCommentLoading());
          await Future.delayed(Duration(seconds: 2));
          List<Comment> comments =
              await _repository.FetchCommentByProductId(_productId);
          emit(ProductCommentSuccess(comments));
        } catch (e) {
          emit(ProductCommentError((e is AppException) ? e : AppException()));
        }
      }
    });
  }
}
