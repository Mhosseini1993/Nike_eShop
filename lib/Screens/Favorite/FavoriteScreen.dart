import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Screens/Favorite/bloc/favorite_bloc.dart';
import 'package:nike/Screens/Product/ProductDetails/ProductDetailsScreen.dart';
import 'package:nike/Screens/Widget/EmptyView.dart';
import 'package:nike/Screens/Widget/FavoriteItem.dart';
import 'package:nike/Screens/Widget/TryAgain.dart';
import 'package:nike/gen/assets.gen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final RefreshController _ref = RefreshController();
  FavoriteBloc? bloc;
  StreamSubscription<FavoriteState>? stream;

  @override
  void dispose() {
    stream!.cancel();
    bloc!.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لیست علاقه مندی ها',
        ),
        centerTitle: true,
      ),
      body: BlocProvider<FavoriteBloc>(
        create: (BuildContext context) {
          bloc = FavoriteBloc(favoriteProductRepository);
          stream = bloc!.stream.listen((state) {
            if (_ref.isRefresh) {
              if (state is FavoriteSuccess) {
                _ref.refreshCompleted();
              }
              else {
                _ref.refreshFailed();
              }
            }
          });
          bloc!.add(FavoriteStarted(isRefreshing: false));
          return bloc!;
        },
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (BuildContext context, FavoriteState state) {
            if (state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is FavoriteSuccess) {
              final products = state.products;
              return SmartRefresher(
                controller: _ref,
                onRefresh: () {
                  bloc!.add(FavoriteStarted(isRefreshing: true));
                },
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
                    padding: const EdgeInsets.only(top: 8, bottom: 100),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FavoriteItem(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext builder) =>
                                  ProductDetailsScreen(
                                      product: products.elementAt(index))),
                        ),
                        onLonPressed: () =>
                            BlocProvider.of<FavoriteBloc>(context).add(
                          FavoriteRemove(
                            products.elementAt(index),
                          ),
                        ),
                        product: products.elementAt(index),
                      );
                    }),
              );
            }
            else if (state is FavoriteEmpty) {
              return Center(
                child: EmptyView(
                    message: 'لیست علاقه مندی های شما خالی می باشد',
                    image: Assets.images.emptyCart.svg(height: 120)),
              );
            }
            else if (state is FavoriteError) {
              return TryAgain(
                retry: () => BlocProvider.of<FavoriteBloc>(context)
                    .add(FavoriteStarted()),
                exception:
                    AppException(message: 'خطا در گرفتن لیست علاقه مندی ها'),
              );
            }
            else {
              throw Exception('State not supported');
            }
          },
        ),
      ),
    );
  }
}
