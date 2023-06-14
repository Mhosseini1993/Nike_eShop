import 'package:hive_flutter/adapters.dart';

part 'Product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject{

  bool isDeleting=false;
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final int discount;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final int previous_price;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.discount,
      required this.image,
      required this.previous_price});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['discount'],
        image = json['image'],
        previous_price = json['previous_price']??(json['price']+json['discount']);
}
