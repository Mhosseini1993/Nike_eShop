import 'package:flutter/material.dart';
import 'package:nike/Screens/Receipt/ReceiptScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EPaymentScreen extends StatelessWidget {
  final String bankGatewayUrl;

  const EPaymentScreen({Key? key, required this.bankGatewayUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: bankGatewayUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (String url) {
        debugPrint(url);
        final myUri = Uri.parse(url);
        if (myUri.host == 'expertdevelopers.ir' &&
            myUri.pathSegments.contains('checkout')) {
          final int orderId =
              int.parse(myUri.queryParameters['order_id'].toString());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ReceiptScreen(orderId: orderId),
            ),
          );
        }
      },
    );
  }
}
