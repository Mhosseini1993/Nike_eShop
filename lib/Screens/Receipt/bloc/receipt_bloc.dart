import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nike/Data/Common/AppException.dart';
import 'package:nike/Data/Models/Receipt/ResultReceiptDto.dart';
import 'package:nike/Data/Repos/Receipt/IReceiptRepository.dart';

part 'receipt_event.dart';

part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final IReceiptRepository _receiptRepository;

  ReceiptBloc(this._receiptRepository) : super(ReceiptLoading()) {
    on<ReceiptEvent>((event, emit) async {
      if (event is ReceiptStarted) {
        try {
          emit(ReceiptLoading());
          await Future.delayed(const Duration(seconds: 2));
          ResultReceiptDto resultReceiptDto =
              await _receiptRepository.GetReceipt(event.orderId);
          emit(ReceiptSuccess(resultReceiptDto));
        } catch (e) {
          emit(ReceiptError(
              (e is AppException) ? e : AppException(message: e.toString())));
        }
      }
    });
  }
}
