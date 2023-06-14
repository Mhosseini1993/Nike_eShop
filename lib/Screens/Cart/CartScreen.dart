import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/Cart/ResultCartListDto.dart';
import 'package:nike/Data/Repos/Auth/AuthRepository.dart';
import 'package:nike/Screens/Cart/bloc/cart_bloc.dart';
import 'package:nike/Screens/Login/AuthScreen.dart';
import 'package:nike/Screens/Shipping/ShippingScreen.dart';
import 'package:nike/Screens/Widget/CartCheckOutInfo.dart';
import 'package:nike/Screens/Widget/CartItem.dart';
import 'package:nike/Screens/Widget/EmptyView.dart';
import 'package:nike/Screens/Widget/TryAgain.dart';
import 'package:nike/gen/assets.gen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  final RefreshController _refreshController = RefreshController();
  StreamSubscription<CartState>? stateSubscription;
  bool isShowBtnPay = false;

  int payable_price = 0;
  int shipping_cost = 0;
  int total_price = 0;

  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
    super.initState();
  }

  void authChangeNotifierListener() {
    //this method call after value of authChangeNotifier changed
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سبد خرید'),
        centerTitle: true,
      ),
      floatingActionButton: Visibility(
        visible: isShowBtnPay,
        child: FloatingActionButton.extended(
          onPressed: () {
            CartState state = cartBloc!.state;
            if (state is CartSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ShippingScreen(
                    payable_price: state.cartListDto.payable_price,
                    shipping_cost: state.cartListDto.shipping_cost,
                    total_price: state.cartListDto.total_price,
                  ),
                ),
              );
            }
          },
          label: SizedBox(
            width: screenSize.width * 0.6,
            child: const Center(
              child: Text('پرداخت'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocProvider<CartBloc>(
        create: (BuildContext context) {
          final bloc = CartBloc(cartRepository);
          stateSubscription = bloc.stream.listen((state) {
            setState(() {
              isShowBtnPay = state is CartSuccess;
            });
            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else {
                _refreshController.refreshFailed();
              }
            }
          });
          cartBloc = bloc;
          cartBloc?.add(
            CartStarted(AuthRepository.authChangeNotifier.value,
                isRefreshing: false),
          );
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (BuildContext context, CartState state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return TryAgain(
                  retry: () => BlocProvider.of<CartBloc>(context).add(
                      CartStarted(AuthRepository.authChangeNotifier.value)),
                  exception: state.exception);
            } else if (state is CartSuccess) {
              final ResultCartListDto data = state.cartListDto;
              return SmartRefresher(
                onRefresh: () {
                  cartBloc?.add(CartStarted(
                      AuthRepository.authChangeNotifier.value,
                      isRefreshing: true));
                },
                controller: _refreshController,
                header: const ClassicHeader(
                  completeText: 'بروزرسانی با موفقیت انجام شد',
                  failedText: 'بروزرسانی با خطا مواجه شد',
                  idleText: 'برای بروزرسانی پایین بکشید',
                  refreshingText: 'در حال بروزرسانی',
                  releaseText: 'رها کنید',
                  spacing: 2,
                  completeIcon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: data.cart_items.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == data.cart_items.length) {
                      return CartCheckOutInfo(
                        total_price: data.total_price,
                        shipping_cost: data.shipping_cost,
                        payable_price: data.payable_price,
                      );
                    } else {
                      return CartItem(
                        removeItem: () => cartBloc?.add(CartDeleteButtonClicked(
                            data.cart_items.elementAt(index).cart_item_id)),
                        increaseCount: () => cartBloc?.add(
                            ChangeItemCountButtomClicked(
                                ++data.cart_items.elementAt(index).count,
                                data.cart_items.elementAt(index).cart_item_id)),
                        decreaseCount: () {
                          if (data.cart_items.elementAt(index).count > 1) {
                            cartBloc?.add(ChangeItemCountButtomClicked(
                                --data.cart_items.elementAt(index).count,
                                data.cart_items.elementAt(index).cart_item_id));
                          }
                        },
                        cartItemDto: data.cart_items.elementAt(index),
                      );
                    }
                  },
                ),
              );
            } else if (state is CartAuthRequired) {
              return Center(
                child: EmptyView(
                  message:
                      'برای مشاهده سبد خرید لطفا وارد حساب کاربری خودتان شوید',
                  image: Assets.images.authRequired.svg(height: 120),
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AuthScreen()),
                      );
                    },
                    child: const Text('ورود به حساب کاربری'),
                  ),
                ),
              );
            } else if (state is CartEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyView(
                      message: 'سبد خرید شما خالی می باشد',
                      image: Assets.images.emptyCart.svg(height: 120)),
                  TryAgain(
                      retry: () => cartBloc?.add(CartStarted(
                          AuthRepository.authChangeNotifier.value,
                          isRefreshing: false)),
                      exception: AppException(message: 'بروز رسانی'))
                ],
              );
            } else {
              throw Exception('State Not Supported');
            }
          },
        ),
      ),
    );
  }
}
