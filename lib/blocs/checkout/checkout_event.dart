part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final User? user;
  final Cart? cart;
  final PaymentMethod? paymentMethod;

  const UpdateCheckout({
   this.user,
    this.paymentMethod,
    this.cart,
  });

  @override
  List<Object?> get props => [
 user,
        cart,
        paymentMethod,
      ];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;
  const ConfirmCheckout({
    required this.checkout,
  });
  @override
  List<Object?> get props => [checkout];
}
