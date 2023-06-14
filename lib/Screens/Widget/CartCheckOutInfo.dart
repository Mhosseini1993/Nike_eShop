import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Utils.dart';

class CartCheckOutInfo extends StatelessWidget {
  final int payable_price;
  final int total_price;
  final int shipping_cost;

  const CartCheckOutInfo(
      {Key? key,
      required this.payable_price,
      required this.total_price,
      required this.shipping_cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            'جزئیات خرید',
            style: theme.textTheme.subtitle1,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
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
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('مبلغ کل خرید', style: theme.textTheme.bodyText1),
                    RichText(
                      text: TextSpan(
                          text: total_price.SeperateWithComma,
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.3)),
                          children: const [
                            TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10))
                          ]),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    shipping_cost == 0
                        ? Text('رایگان',
                            style: theme.textTheme.headline6!
                                .apply(fontSizeFactor: 0.8))
                        : RichText(
                            text: TextSpan(
                              text: (shipping_cost + 10000).SeperateWithComma,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                              children: const [
                                TextSpan(
                                    text: ' تومان',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),)
                              ],
                            ),
                          )
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                        text: payable_price.SeperateWithComma,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                            text: ' تومان',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
