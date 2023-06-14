import 'package:nike/Data/Models/Product/Product.dart';

class ResultOrderHistoryDto {
  final List<OrderItem> OrderItems;
  ResultOrderHistoryDto.fromJson(dynamic json)
      : OrderItems = (json as List).map((e) => OrderItem.fromJson(e)).toList();
}

class OrderItem {
  final int id;
  final int payable;
  final List<Item> order_items;

  OrderItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payable = json['payable'],
        order_items =(json['order_items'] as List).map((e) => Item.fromJson(e)).toList();
}

class Item {
  final Product product;
  Item.fromJson(Map<String, dynamic> json)
      : product = Product.fromJson(json['product']);
}
