import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final Widget image;
  final String message;
  final Widget? callToAction;

  const EmptyView({
    Key? key,
    required this.message,
    required this.image,
    this.callToAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.only(left: 48,right: 48,top: 24,bottom: 16),
          child: Text(
            message,
            style: Theme.of(context).textTheme!.headline6!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ),
        if (callToAction != null) callToAction!
      ],
    );
  }
}
