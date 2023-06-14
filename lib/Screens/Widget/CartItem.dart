import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Models/Cart/CartItemDto.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';

class CartItem extends StatelessWidget {
  final CartItemDto cartItemDto;
  final void Function() removeItem;
  final void Function() increaseCount;
  final void Function() decreaseCount;
  const CartItem({Key? key, required this.cartItemDto, required this.removeItem, required this.increaseCount, required this.decreaseCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ImageLoader(
                    imageUrl: cartItemDto.product.image,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(child: Text(cartItemDto.product.title))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                     const Text('تعداد'),
                    Row(
                      children: [
                        IconButton(
                          onPressed: increaseCount,
                          icon: const Icon(CupertinoIcons.plus_rectangle),
                        ),
                        cartItemDto.changeCountLoading?const CupertinoActivityIndicator():Text(cartItemDto.count.toString()),
                        IconButton(
                          onPressed: decreaseCount,
                          icon: const Icon(CupertinoIcons.minus_rectangle),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      cartItemDto.product.previous_price.toString(),
                      style: theme.textTheme.caption!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      cartItemDto.product.price.toString(),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          cartItemDto.deleteButtonLoading?const CupertinoActivityIndicator():
          TextButton(onPressed: removeItem, child: const Text('حذف از سبد خرید'))
        ],
      ),
    );
  }
}
