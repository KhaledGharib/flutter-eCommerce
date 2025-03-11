import 'package:ecommerce/utility/app_icons.dart';

class PaymentMethodModel {
  final String name;
  final String number;
  final String icon;
  final String expire;
  final String ccv;

  PaymentMethodModel({
    required this.name,
    required this.number,
    required this.icon,
    required this.expire,
    required this.ccv,
  });
}

List<PaymentMethodModel> paymentMethodList = [
  PaymentMethodModel(
    name: "Paypal",
    number: '1234123412341234',
    icon: AppIcons.paypal,
    expire: "20/20",
    ccv: "123",
  ),
  PaymentMethodModel(
    name: "Mastercard",
    number: '1234123412341234',
    icon: AppIcons.masterCardSVG,
    expire: "20/20",
    ccv: "123",
  ),
  PaymentMethodModel(
    name: "Visa",
    number: '1234123412341234',
    icon: AppIcons.visaSVG,
    expire: "20/20",
    ccv: "123",
  ),
];
