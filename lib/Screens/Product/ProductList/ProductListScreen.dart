import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Enums.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Models/Product/ProductSortType.dart';
import 'package:nike/Screens/Product/ProductList/bloc/product_list_bloc.dart';
import 'package:nike/Screens/Widget/ProductItem.dart';
import 'package:nike/Screens/Widget/TryAgain.dart';

class ProductListScreen extends StatefulWidget {
  final int sortType;

  const ProductListScreen({Key? key, required this.sortType}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ViewType viewType = ViewType.GRID;
  ProductListBloc? bloc;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کفش نایک'),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (BuildContext context) =>
            bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(widget.sortType)),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is ProductListError) {
              return TryAgain(
                  retry: () => BlocProvider.of<ProductListBloc>(context)
                      .add(ProductListStarted(widget.sortType)),
                  exception: state.exception);
            }
            else if (state is ProductListSuccess) {
              final List<Product> data = state.products;
              return Column(
                children: [
                  const Divider(),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                topRight: Radius.circular(24))),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 24, bottom: 24),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'انتخاب مرتب سازی',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: ProductSortType
                                                          .Names.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        int selectedIndex =
                                                            state.sortType;
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 16,
                                                                  top: 8,
                                                                  right: 16,
                                                                  bottom: 8),
                                                          child: InkWell(
                                                            onTap: () {
                                                              bloc!.add(
                                                                  ProductListStarted(
                                                                      index));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: SizedBox(
                                                              height: 32,
                                                              child: Row(
                                                                children: [
                                                                  if (index ==
                                                                      selectedIndex)
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              4),
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .check_mark_circled_solid,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    )
                                                                  else
                                                                    const SizedBox(
                                                                        width:
                                                                            28),
                                                                  Text(ProductSortType
                                                                          .Names[
                                                                      index]),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  icon: const Icon(CupertinoIcons.sort_down)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('مرتب سازی'),
                                  Text(
                                    ProductSortType.Names[state.sortType],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            viewType = (viewType == ViewType.GRID)
                                ? ViewType.LIST
                                : ViewType.GRID;
                          }),
                          icon: Icon(viewType == ViewType.GRID
                              ? CupertinoIcons.list_bullet
                              : CupertinoIcons.square_grid_2x2),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: viewType == ViewType.GRID ? 2 : 1,
                      childAspectRatio: 0.63,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItem(
                        product: data.elementAt(index),
                        borderRadius: BorderRadius.zero,
                      );
                    },
                  ))
                ],
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
