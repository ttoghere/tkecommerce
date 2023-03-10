import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
    on<StartPayment>(_onStartPayment);
    on<SelectPaymentMethod>(_selectPaymentMethod);
    on<CreatePaymentIntent>(_onCreatePaymentIntent);
  }

  void _selectPaymentMethod(
      SelectPaymentMethod event, Emitter<PaymentState> emit) {
    emit(
      state.copyWith(
        paymentMethod: event.paymentMethod,
        paymentMethodId: event.paymentMethodId,
      ),
    );
  }

  void _onStartPayment(StartPayment event, Emitter<PaymentState> emit) {
    emit(
      state.copyWith(
        paymentStatus: PaymentStatus.initial,
      ),
    );
  }

  void _onCreatePaymentIntent(
      CreatePaymentIntent event, Emitter<PaymentState> emit) async {
    emit(
      state.copyWith(
        paymentStatus: PaymentStatus.loading,
      ),
    );
    // final paymentIntentResult = await _callPayEndpointMethodId(
    //   useStripeSdk: true,
    //   paymentMethodId: event.paymentMethodId,
    //   currency: "usd",
    //   amount: event.amount,
    // );
  }

  // Future<Map<String, dynamic>> _callPayEndpointMethodId({
  //   required bool useStripeSdk,
  //   required String paymentMethodId,
  //   required String currency,
  //   required int amount,
  // }) async {
  //   final url = Uri.parse(uri);
  // }
}
