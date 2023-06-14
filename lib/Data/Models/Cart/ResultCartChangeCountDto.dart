class ResultCartChangeCountDto{
  final int id;
  final int product_id;
  final int count;

  ResultCartChangeCountDto.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        product_id = json["product_id"],
        count = json["count"];

}