import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Utils.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';

class FavoriteItem extends StatelessWidget {
  final Product product;
  final void Function() onTap;
  final void Function() onLonPressed;

  const FavoriteItem(
      {Key? key,
      required this.product,
      required this.onTap,
      required this.onLonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLonPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        child: Row(
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: product.isDeleting
                  ? const Center(child: CircularProgressIndicator())
                  : ImageLoader(
                      imageUrl: product.image,
                      borderRadius: BorderRadius.circular(8)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      product.previous_price.SeperateWithComma,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(product.price.SeperateWithComma)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
