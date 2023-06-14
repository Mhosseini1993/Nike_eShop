import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Utils.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Screens/Product/ProductDetails/ProductDetailsScreen.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final BorderRadius borderRadius;

  const ProductItem(
      {Key? key, required this.product, required this.borderRadius})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
          ),
        ),
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.93,
                    child: ImageLoader(
                      imageUrl: widget.product.image,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () async {
                        if (!favoriteProductRepository.IsFavorite(
                            widget.product)) {
                          favoriteProductRepository.AddToGavorite(
                              widget.product);
                        } else {
                          favoriteProductRepository.RemoveFromGavorite(
                              widget.product);
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          favoriteProductRepository.IsFavorite(widget.product)
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  widget.product.previous_price.PriceWithLabel,
                  style: theme.textTheme.caption!
                      .apply(decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Text(
                  widget.product.price.PriceWithLabel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
