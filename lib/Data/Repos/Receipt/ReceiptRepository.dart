import 'package:nike/Data/Models/Receipt/ResultReceiptDto.dart';
import 'package:nike/Data/Source/Receipt/IReceiptDataSource.dart';

import 'IReceiptRepository.dart';

class ReceiptRepository implements IReceiptRepository {
  final IReceiptDataSource _remoteDataSource;

  ReceiptRepository(this._remoteDataSource);

  @override
  Future<ResultReceiptDto> GetReceipt(int orderId) =>
      _remoteDataSource.GetReceipt(orderId);
}
