import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Utils.dart';
import 'package:nike/Screens/OrderHistory/bloc/order_history_bloc.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';

import '../../Data/Common/AppException.dart';
import '../../gen/assets.gen.dart';
import '../Widget/EmptyView.dart';
import '../Widget/TryAgain.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوابق سفارش'),
        centerTitle: true,
      ),
      body: BlocProvider<OrderHistoryBloc>(
        create: (BuildContext context) {
          final bloc = OrderHistoryBloc(orderRepository);
          bloc.add(OrderHistoryStarted());
          return bloc;
        },
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (BuildContext context, OrderHistoryState state) {
          if (state is OrderHistoryLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          else if (state is OrderHistorySuccess) {
            final data = state.orderHistoryDto.OrderItems;
            return ListView.builder(
              physics: defaultScrollPhysics,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int firstIndex) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(16,8,16,8),
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //56
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('شناسه سفارش'),
                            Text(data.elementAt(firstIndex).id.toString())
                          ],
                        ),
                        const SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('مبلغ سفارش'),
                            Text(
                                data.elementAt(firstIndex).payable.PriceWithLabel)
                          ],
                        ),
                        const SizedBox(height: 24,),
                        Expanded(
                          child: ListView.builder(
                            physics: defaultScrollPhysics,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.elementAt(firstIndex).order_items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ImageLoader(
                                        imageUrl: data
                                            .elementAt(firstIndex)
                                            .order_items
                                            .elementAt(index)
                                            .product
                                            .image,
                                    borderRadius: BorderRadius.circular(8),)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else if (state is OrderHistoryEmpty) {
            return Center(
              child: EmptyView(
                  message: 'سوابق سفارش شما خالی می باشد',
                  image: Assets.images.emptyCart.svg(height: 120)),
            );
          }
          else if (state is OrderHistoryError) {
            return TryAgain(
              retry: () => BlocProvider.of<OrderHistoryBloc>(context)
                  .add(OrderHistoryStarted()),
              exception:
              AppException(message: 'خطا در گرفتن سوابق سفارش'),
            );
          }
          else {
            throw Exception('State is not supported');
          }
        }),
      ),
    );
  }
}
