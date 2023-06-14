import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Enums.dart';
import 'package:nike/Data/Models/Order/RequestAddOrderDto.dart';
import 'package:nike/Screens/EPaymentScreen/EPaymentScreen.dart';
import 'package:nike/Screens/Receipt/ReceiptScreen.dart';
import 'package:nike/Screens/Shipping/bloc/order_bloc.dart';
import 'package:nike/Screens/Widget/CartCheckOutInfo.dart';

class ShippingScreen extends StatefulWidget {
  final int payable_price;
  final int shipping_cost;
  final int total_price;

  ShippingScreen(
      {Key? key,
      required this.payable_price,
      required this.shipping_cost,
      required this.total_price})
      : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController _txtFirstName =
      TextEditingController();
  final TextEditingController _txtLastName =
  TextEditingController();
  final TextEditingController _txtPostalCode =
  TextEditingController();
  final TextEditingController _txtMobileNumber =
  TextEditingController();
  final TextEditingController _txtAddress = TextEditingController();
  StreamSubscription<OrderState>? stream;
  PaymentMethod payMethod = PaymentMethod.ONLINE;

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب تحویل گیرنده و شیوه پرداخت'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 32),
          child: Column(
            children: [
              TextField(
                controller: _txtFirstName,
                decoration: const InputDecoration(
                  label: Text(
                    'نام',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtLastName,
                decoration: const InputDecoration(
                  label: Text(
                    'نام خانوادگی',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtPostalCode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text(
                    'کد پستی',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtMobileNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    label: Text(
                  'شماره تماس',
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _txtAddress,
                decoration: const InputDecoration(
                  label: Text(
                    'آدرس تحویل گیرنده',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CartCheckOutInfo(
                payable_price: widget.payable_price,
                shipping_cost: widget.shipping_cost,
                total_price: widget.total_price,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider<OrderBloc>(
                create: (BuildContext context) {
                  OrderBloc bloc = OrderBloc(orderRepository);
                  stream = bloc.stream.listen((state) {
                    if (state is OrderSuccess) {
                      if (state.result.bankGatewayUrl.isEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ReceiptScreen(
                              orderId: state.result.orderId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => EPaymentScreen(
                              bankGatewayUrl: state.result.bankGatewayUrl,
                            ),
                          ),
                        );
                      }
                    } else if (state is OrderError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.exception.message)));
                    }
                  });
                  return bloc;
                },
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (BuildContext context, OrderState state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(180, 60),
                            ),
                          ),
                          onPressed: () {
                            payMethod = PaymentMethod.PAYONTHESPOT;
                            BlocProvider.of<OrderBloc>(context).add(
                              CreateOrder(
                                RequestAddOrderDto(
                                  _txtFirstName.text,
                                  _txtLastName.text,
                                  _txtPostalCode.text,
                                  _txtMobileNumber.text,
                                  _txtAddress.text,
                                  PaymentMethod.PAYONTHESPOT,
                                ),
                              ),
                            );
                          },
                          child: (state is OrderLoading &&
                                  payMethod == PaymentMethod.PAYONTHESPOT)
                              ? const CupertinoActivityIndicator()
                              : const Text('پرداخت در محل'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(180, 60),
                            ),
                          ),
                          onPressed: () {
                            payMethod = PaymentMethod.ONLINE;
                            BlocProvider.of<OrderBloc>(context).add(
                              CreateOrder(
                                RequestAddOrderDto(
                                  _txtFirstName.text,
                                  _txtLastName.text,
                                  _txtPostalCode.text,
                                  _txtMobileNumber.text,
                                  _txtAddress.text,
                                  PaymentMethod.ONLINE,
                                ),
                              ),
                            );
                          },
                          child: (state is OrderLoading &&
                                  payMethod == PaymentMethod.ONLINE)
                              ? const CupertinoActivityIndicator()
                              : const Text('پرداخت اینترنتی'),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
