import '../../Models/Receipt/ResultReceiptDto.dart';
abstract class IReceiptDataSource{
  Future<ResultReceiptDto> GetReceipt(int orderId);
}