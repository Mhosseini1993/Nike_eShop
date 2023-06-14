import 'package:nike/Data/Common/Enums.dart';

class RequestAddOrderDto {
  final String firstName;
  final String lastName;
  final String postalCode;
  final String mobile;
  final String address;
  final PaymentMethod paymentMethod;

  RequestAddOrderDto(
    this.firstName,
    this.lastName,
    this.postalCode,
    this.mobile,
    this.address,
    this.paymentMethod,
  );

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'postal_code': postalCode,
      'mobile': mobile,
      'address': address,
      'payment_method':
      paymentMethod == PaymentMethod.ONLINE ? 'online' : 'offline',
    };
  }
}
