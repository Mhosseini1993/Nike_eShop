import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Screens/Widget/ProductItem.dart';

class HorizentalProductList extends StatelessWidget {
  final List<Product> products;
  final String title;
  final void Function() onTap;

  const HorizentalProductList(
      {Key? key,
      required this.products,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.subtitle1,
              ),
              TextButton(
                onPressed:  onTap,
                child: const Text('مشاهده همه'),
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: ListView.builder(
            physics: defaultScrollPhysics,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(
                product: products.elementAt(index),
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
        )
      ],
    );
  }
}
