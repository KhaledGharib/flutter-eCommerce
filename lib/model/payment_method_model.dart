import 'package:ecommerce/utility/app_icons.dart';

class PaymentMethodModel {
  final String name;
  final String number;
  final String icon;

  PaymentMethodModel({
    required this.name,
    required this.number,
    required this.icon,
  });
}

List<PaymentMethodModel> paymentMethodList = [
  PaymentMethodModel(
    name: "Paypal",
    number: '1234123412341234',
    icon: AppIcons.paypal,
  ),
  PaymentMethodModel(
    name: "Mastercard",
    number: '1234123412341234',
    icon: AppIcons.masterCardSVG,
  ),
  PaymentMethodModel(
    name: "Visa",
    number: '1234123412341234',
    icon: AppIcons.visaSVG,
  ),
];
