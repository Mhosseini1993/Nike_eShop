class ResultAddToCartDto {
  final int id;
  final int product_id;
  final int count;

  ResultAddToCartDto.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        product_id = json["product_id"],
        count = json["count"];
}
