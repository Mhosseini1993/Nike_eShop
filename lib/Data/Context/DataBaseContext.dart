import 'package:hive_flutter/adapters.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/Product/Product.dart';

class DataBaseContext {
  static Future<void> initDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    await Hive.openBox<Product>(ProductBoxName);
  }
}
