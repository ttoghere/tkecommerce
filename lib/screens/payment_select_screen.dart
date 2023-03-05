import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import 'package:tkecommerce/app_shelf.dart';

class PaymentSelectScreen extends StatelessWidget {
  static const routeName = "/paymentselect";
  const PaymentSelectScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PaymentSelectScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PaymentLoaded) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                              const SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.creditCard));
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Text("Stripe"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Platform.isAndroid
                          ? Column(
                              children: [
                                RawGooglePayButton(
                                  type: GooglePayButtonType.pay,
                                  onPressed: () {
                                    context.read<PaymentBloc>().add(
                                        const SelectPaymentMethod(
                                            paymentMethod:
                                                PaymentMethod.googlePay));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Platform.isIOS
                          ? Column(
                              children: [
                                RawApplePayButton(
                                  style: ApplePayButtonStyle.black,
                                  type: ApplePayButtonType.inStore,
                                  onPressed: () {
                                    context.read<PaymentBloc>().add(
                                        const SelectPaymentMethod(
                                            paymentMethod:
                                                PaymentMethod.applePay));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
    );
  }
}
