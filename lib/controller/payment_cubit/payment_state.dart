part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentLoaded extends PaymentState {
  final List<PaymentMethodModel> paymentList;

  PaymentLoaded({required this.paymentList});
}

final class PaymentSuccess extends PaymentState {}
