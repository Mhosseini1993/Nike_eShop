class ResultReceiptDto{
  final bool purchaseSucess;
  final int payablePrice;
  final String paymentStatus;
  ResultReceiptDto.fromJson(Map<String,dynamic> map):
        purchaseSucess=map['purchase_success'],
        payablePrice=map['payable_price'],
        paymentStatus=map['payment_status'];
}