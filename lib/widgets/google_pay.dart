import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tkecommerce/app_shelf.dart';


class GooglePay extends StatelessWidget {
  final String total;
  final List<Product> products;
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);
  void onGooglePayResult(paymentResult) {
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
      child: GooglePayButton(
        onPaymentResult: onGooglePayResult,
        paymentItems: paymentItems,
        paymentConfigurationAsset: "payment_profile_google_pay.json",
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
        type: GooglePayButtonType.pay,
      ),
    );
  }
}
