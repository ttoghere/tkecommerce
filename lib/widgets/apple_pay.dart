// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tkecommerce/app_shelf.dart';

class ApplePay extends StatelessWidget {
  final String total;
  final List<Product> products;
  const ApplePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);
  void onApplePayResult(paymentResult) {
    log("Payment Result: $paymentResult");
  }

  @override
  Widget build(BuildContext context) {
    var paymentItems = products
        .map(
          (e) => PaymentItem(
            amount: e.price.toString(),
            label: e.name,
            type: PaymentItemType.total,
            status: PaymentItemStatus.final_price,
          ),
        )
        .toList();
    paymentItems.add(PaymentItem(amount: total, label: "Total"));

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ApplePayButton(
        onPaymentResult: onApplePayResult,
        paymentItems: paymentItems,
        paymentConfigurationAsset: "payment_profile_apple_pay.json",
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
