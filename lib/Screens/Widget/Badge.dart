import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int value;

  const Badge({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Visibility(
      visible: value != 0,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
