class ResultAddOrderDto {
  final int orderId;
  final String bankGatewayUrl;

  ResultAddOrderDto.fromJson(Map<String, dynamic> map)
      : orderId = map['order_id']??0,
        bankGatewayUrl = map['bank_gateway_url']??'';
}
