import 'package:nike/Data/Models/Cart/CartItemDto.dart';

class ResultCartListDto {
   final List<CartItemDto> cart_items;
   int payable_price;
   int total_price;
   int shipping_cost;

  ResultCartListDto.fromJson(Map<String, dynamic> json)
      : cart_items = (json['cart_items'] as List)
            .map((e) => CartItemDto.fromJson(e))
            .toList(),
        payable_price = json['payable_price'],
        total_price = json['total_price'],
        shipping_cost = json['shipping_cost'];
}
