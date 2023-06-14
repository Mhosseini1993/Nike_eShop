import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Utils.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Screens/Product/ProductDetails/InitCartBloc/init_cart_bloc.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';
import 'package:nike/Screens/Widget/ProductCommets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<InitCartState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey=GlobalKey();

  @override
  void dispose() {
    stateSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<InitCartBloc>(
        create: (BuildContext context) {
          final bloc = InitCartBloc(cartRepository);
          stateSubscription = bloc.stream.listen((InitCartState state) {
            if (state is InitCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(const SnackBar(
                content: Text('محصول با موفقیت به سبد خرید افزوده شد'),
              ));
            } else if (state is InitCartError) {
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                content: Text(state.exception.message),
              ));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: screenSize.width * 0.8,
                  flexibleSpace: ImageLoader(imageUrl: widget.product.image),
                  actions: [
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(CupertinoIcons.heart))
                  ],
                  foregroundColor: Colors.black,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: theme.textTheme.headline6!
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previous_price.PriceWithLabel,
                                  style: theme.textTheme.caption!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(widget.product.price.PriceWithLabel)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          CNT_PRODUCT_DESC,
                          style: theme.textTheme.subtitle1!.copyWith(height: 1.4),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: theme.textTheme.subtitle1,
                            ),
                            TextButton(
                                onPressed: () => {}, child: Text('ثبت نظر'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ProductCommets(
                  productId: widget.product.id,
                )
              ],
            ),
            floatingActionButton: BlocBuilder<InitCartBloc, InitCartState>(
              builder: (context, state) {
                return FloatingActionButton.extended(
                  onPressed: () => BlocProvider.of<InitCartBloc>(context)
                      .add(AddToCartButtonClicked(widget.product.id)),
                  label: SizedBox(
                    width: screenSize.width * 0.8,
                    child: Center(
                      child: (state is InitCartLoading)
                          ? const CupertinoActivityIndicator()
                          : const Text('افزودن به سبد خرید'),
                    ),
                  ),
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }
}
