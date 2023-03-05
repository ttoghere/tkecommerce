// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

enum PaymentMethod { applePay, googlePay, creditCard }

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentMethod paymentMethod;
  const PaymentLoaded({
    this.paymentMethod = PaymentMethod.applePay,
  });

  @override
  List<Object> get props => [paymentMethod];
}
