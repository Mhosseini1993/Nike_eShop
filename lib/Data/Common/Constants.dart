import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike/Data/Models/Product/Product.dart';
import 'package:nike/Data/Repos/Auth/AuthRepository.dart';
import 'package:nike/Data/Repos/Baner/BanerRepository.dart';
import 'package:nike/Data/Repos/Cart/CartRepository.dart';
import 'package:nike/Data/Repos/Comment/CommentRepository.dart';
import 'package:nike/Data/Repos/FavoriteProduct/FavoriteProductRepository.dart';
import 'package:nike/Data/Repos/Order/OrderRepository.dart';
import 'package:nike/Data/Repos/Product/ProductRepository.dart';
import 'package:nike/Data/Repos/Receipt/ReceiptRepository.dart';
import 'package:nike/Data/Source/Auth/RemoteAuthDataSource.dart';
import 'package:nike/Data/Source/Baner/RemoteBanerDataSource.dart';
import 'package:nike/Data/Source/Cart/RemoteCartDataSource.dart';
import 'package:nike/Data/Source/Comment/RemoteCommentDataSource.dart';
import 'package:nike/Data/Source/FavoriteProduct/HiveFavoriteProductDataSource.dart';
import 'package:nike/Data/Source/Order/RemoteOrderDataSource.dart';
import 'package:nike/Data/Source/Product/RemoteProductDataSource.dart';
import 'package:nike/Data/Source/Receipt/RemoteReceiptDataSource.dart';

final httpClient = Dio(BaseOptions(
  baseUrl: CNT_BASE_URL,
  validateStatus: (_) => true,
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authInfo = AuthRepository.authChangeNotifier.value;
      if (authInfo != null && authInfo.access_token!.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authInfo.access_token!}';
      }
      handler.next(options);
    },
  ));

const defaultScrollPhysics = BouncingScrollPhysics();
final productRepository = ProductRepository(RemoteProductDataSource(httpClient));
final banerRepository = BanerRepository(RemoteBanerDataSource(httpClient));
final commentRepository = CommentRepository(RemoteCommentDataSource(httpClient));
final authRepository = AuthRepository(RemoteAuthDataSource(httpClient));
final cartRepository = CartRepository(RemoteCartDataSource(httpClient));
final orderRepository = OrderRepository(RemoteOrderDataSource(httpClient));
final receiptRepository = ReceiptRepository(RemoteReceiptDataSource(httpClient));
final _db = Hive.box<Product>(ProductBoxName);
final favoriteProductRepository = FavoriteProductRepository(HiveFavoriteProductDataSource(_db));
late ValueListenable<Box<Product>> favoriteListenable=_db.listenable();

const String CNT_BASE_URL = 'http://expertdevelopers.ir/api/v1';
const String CNT_PRODUCT_DESC =
    'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست، و تقریبا هیچ فشار مخربی را به زانو و پا وارد نمی کند';
const String CNT_CLIENT_SECRET = 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC';
const String CNT_ACCESS_TOKEN = 'AccessToken';
const String CNT_REFRESH_TOKEN = 'RefreshToken';
const String CNT_USER_EMAIL = 'Email';
const String ProductBoxName = 'ProductBox';
