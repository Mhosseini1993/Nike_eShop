import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Screens/Product/ProductDetails/ProductCommentBloc/product_comment_bloc.dart';
import 'package:nike/Screens/Widget/CommentItem.dart';
import 'package:nike/Screens/Widget/TryAgain.dart';

class ProductCommets extends StatelessWidget {
  final int productId;

  const ProductCommets({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCommentBloc>(
      create: (BuildContext context) {
        final ProductCommentBloc bloc = ProductCommentBloc(commentRepository, productId);
        bloc.add(ProductCommentStarted());
        return bloc;
      },
      child: BlocBuilder<ProductCommentBloc, ProductCommentState>(
          builder: (BuildContext context, ProductCommentState state) {
        if (state is ProductCommentSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CommentItem(
                comment: state.comments.elementAt(index),
              );
            }, childCount: state.comments.length),
          );
        }
        else if (state is ProductCommentLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else if (state is ProductCommentError) {
          return SliverToBoxAdapter(
            child: TryAgain(
              exception: state.exception,
              retry: () => BlocProvider.of<ProductCommentBloc>(context)
                  .add(ProductCommentRefreshed()),
            ),
          );
        }
        else {
          throw Exception('State is not supported');
        }
      }),
    );
  }
}
