import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Utils.dart';
import 'package:nike/Screens/Receipt/bloc/receipt_bloc.dart';

class ReceiptScreen extends StatelessWidget {
  final int orderId;
  const ReceiptScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocProvider<ReceiptBloc>(
      create: (BuildContext context) {
        final ReceiptBloc bloc = ReceiptBloc(receiptRepository);
        bloc.add(ReceiptStarted(this.orderId));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('رسید پرداخت'),
          centerTitle: true,
        ),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptError) {
              return const Center(child: Text('خطای رخ داده است'));
            }
            else if (state is ReceiptLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is ReceiptSuccess) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.receiptDto.purchaseSucess
                              ? 'پرداخت با موفقیت انجام شد'
                              : 'پرداخت ناموفق',
                          style: theme.textTheme.headline6!.apply(
                            color: state.receiptDto.purchaseSucess
                                ? theme.colorScheme.primary
                                : Colors.red,
                            fontSizeFactor: 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'وضعیت سفارش',
                              style: TextStyle(
                                  color: theme.colorScheme.secondary
                                      .withOpacity(0.5)),
                            ),
                            Text(
                              state.receiptDto.paymentStatus,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'مبلغ',
                              style: TextStyle(
                                  color: theme.colorScheme.secondary
                                      .withOpacity(0.5)),
                            ),
                            Text(
                              state.receiptDto.payablePrice.SeperateWithComma,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () => {},
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(180, 60),
                          ),
                        ),
                        child: const Text('سوابق سفارش'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(180, 60),
                          ),
                        ),
                        child: const Text('بازگشت به صفحه اصلی'),
                      )
                    ],
                  )
                ],
              );
            }
            else {
              throw Exception('state not supported');
            }
          },
        ),
      ),
    );
  }
}
