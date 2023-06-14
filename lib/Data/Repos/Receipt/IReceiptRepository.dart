import 'package:nike/Data/Models/Receipt/ResultReceiptDto.dart';
abstract class IReceiptRepository{
  Future<ResultReceiptDto> GetReceipt(int orderId);
}