import 'package:intl/intl.dart';

extension PriceLabel on int{

  String get PriceWithLabel=>'$SeperateWithComma تومان ';

  String get SeperateWithComma{
    final NumberFormat numberFormat=NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }

}