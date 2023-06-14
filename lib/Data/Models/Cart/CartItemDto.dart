import 'package:nike/Data/Models/Product/Product.dart';

class CartItemDto{
  final int cart_item_id;
  final Product product;
   int count;
  bool deleteButtonLoading=false;
  bool changeCountLoading=false;

  CartItemDto.fromJson(Map<String,dynamic> json):
        cart_item_id=json['cart_item_id'],
        product=Product.fromJson(json['product']),
        count=json['count'];
  
}