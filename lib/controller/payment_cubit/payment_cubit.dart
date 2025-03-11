import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/model/payment_method_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  void getPaymentMethod() {
    emit(PaymentLoading());

    emit(PaymentLoaded(paymentList: paymentMethodList));
  }

  void savePaymentMethod(PaymentMethodModel paymentData) {
    emit(PaymentLoading());

    paymentMethodList.add(paymentData);
    emit(PaymentSuccess());
    // emit(PaymentLoaded(paymentList: paymentMethodList));
  }
}
