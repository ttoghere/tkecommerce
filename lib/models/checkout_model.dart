// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tkecommerce/app_shelf.dart';

class Checkout extends Equatable {
  final String? id;
  final User? user;
  final Cart cart;
  final PaymentMethod paymentMethod;
  final String? paymentMethodId;
  final bool isPaymentSuccesful;
  const Checkout({
    this.id = "",
    this.user,
    required this.cart,
    this.paymentMethod = PaymentMethod.creditCard,
    this.paymentMethodId,
    this.isPaymentSuccesful = false,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        cart,
        paymentMethod,
        paymentMethodId,
        isPaymentSuccesful,
      ];

  Map<String, Object> toDocument() {
    return {
      "user": user?.toDocument() ?? User.empty.toDocument(),
      "cart": cart.toDocument(),
      "paymentMethod": paymentMethod.name,
      "paymentMethodId": paymentMethodId ?? "",
      "isPaymentSuccesful": isPaymentSuccesful,
    };
  }

  static Checkout fromJson(Map<String, dynamic> json, [String? id]) {
    Checkout checkout = Checkout(
        cart: Cart.fromJson(
          json["cart"],
        ),
        id: id ?? json["id"],
        user: User.fromJson(
          json["user"],
        ),
        paymentMethod: PaymentMethod.values.firstWhere(
          (element) =>
              element.toString().split(".").last == json["paymentMethod"],
        ),
        paymentMethodId: json["paymentMethodId"],
        isPaymentSuccesful: json["isPaymentSuccesful"]);
    return checkout;
  }

  Checkout copyWith({
    String? id,
    User? user,
    Cart? cart,
    PaymentMethod? paymentMethod,
    String? paymentMethodId,
    bool? isPaymentSuccesful,
  }) {
    return Checkout(
      id: id ?? this.id,
      user: user ?? this.user,
      cart: cart ?? this.cart,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      isPaymentSuccesful: isPaymentSuccesful ?? this.isPaymentSuccesful,
    );
  }
}
