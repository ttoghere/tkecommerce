// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

enum PaymentMethod { applePay, googlePay, creditCard }

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  final PaymentStatus paymentStatus;
  final PaymentMethod paymentMethod;
  final stripe.CardFieldInputDetails? cardFieldInputDetails;
  final String? paymentMethodId;
  const PaymentState({
    this.paymentStatus = PaymentStatus.initial,
    this.paymentMethod = PaymentMethod.creditCard,
    this.cardFieldInputDetails = const stripe.CardFieldInputDetails(complete: false),
    this.paymentMethodId,
  });

  @override
  List<Object?> get props => [paymentMethod,paymentStatus,paymentMethodId,cardFieldInputDetails];

  PaymentState copyWith({
    PaymentStatus? paymentStatus,
    PaymentMethod? paymentMethod,
    stripe.CardFieldInputDetails? cardFieldInputDetails,
    String? paymentMethodId,
  }) {
    return PaymentState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardFieldInputDetails: cardFieldInputDetails ?? this.cardFieldInputDetails,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }
}

