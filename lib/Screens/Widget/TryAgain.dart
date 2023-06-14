import 'package:flutter/material.dart';
import 'package:nike/Data/Common/AppException.dart';

class TryAgain extends StatelessWidget {
  final void Function() retry;
  final AppException exception;
  const TryAgain({Key? key, required this.retry, required this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed:  retry, child: const Text('تلاش دوباره'))
        ],
      ),
    );
  }
}
