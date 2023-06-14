import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/Product/ProductSortType.dart';
import 'package:nike/Screens/Home/bloc/home_bloc.dart';
import 'package:nike/Screens/Product/ProductList/ProductListScreen.dart';
import 'package:nike/Screens/Widget/BanerSlider.dart';
import 'package:nike/Screens/Widget/HorizentalProductList.dart';
import 'package:nike/Screens/Widget/TryAgain.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final HomeBloc homeBloc = HomeBloc(banerRepository, productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: ((BuildContext context, HomeState state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: defaultScrollPhysics,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/nike_logo.png',
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      case 1:
                        return const Text('Search bar');
                      case 2:
                        return BanerSlider(
                          baners: state.baners,
                        );
                      case 3:
                        return HorizentalProductList(
                          title: 'جدیدترین',
                          products: state.latestProducts,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductListScreen(
                                sortType: ProductSortType.Latest,
                              ),
                            ),
                          ),
                        );
                      case 4:
                        return HorizentalProductList(
                          title: 'پربازدید ترین',
                          products: state.popularProducts,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductListScreen(
                                sortType: ProductSortType.Popular,
                              ),
                            ),
                          ),
                        );
                      default:
                        return const Text('data');
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return TryAgain(
                  exception: state.exception,
                  retry: () =>
                      BlocProvider.of<HomeBloc>(context).add(HomeRefreshed()),
                );
              } else {
                throw Exception('state is not supported');
              }
            }),
          ),
        ),
      ),
    );
  }
}
