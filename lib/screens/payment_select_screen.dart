// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
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
          if (state.paymentStatus == PaymentStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.paymentStatus == PaymentStatus.initial) {
            return paymentMethods(context);
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
    );
  }

  Center paymentMethods(BuildContext context) {
    stripe.CardFormEditController controller = stripe.CardFormEditController();
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add your Credit Card Details",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              stripe.CardFormField(
                controller: controller,
                style: stripe.CardFormStyle(
                  placeholderColor: Colors.white,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderWidth: 5,
                  borderColor: Colors.red[900],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                onPressed: () async {
                  // if (controller.details.complete) {
                  //   final stripePaymentMethod = await stripe.Stripe.instance
                  //       .createPaymentMethod(stripe.PaymentMethodParams.card(
                  //     paymentMethodData: stripe.PaymentMethodData(
                  //       billingDetails: stripe.BillingDetails(
                  //         email: (context.read<CheckoutBloc>().state
                  //                 as CheckoutLoaded)
                  //             .user!
                  //             .email,
                  //       ),
                  //     ),
                  //   ));
                  context.read<PaymentBloc>().add(const SelectPaymentMethod(
                      paymentMethod: PaymentMethod.creditCard));
                  Navigator.pop(context);
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
                                    paymentMethod: PaymentMethod.googlePay));
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
                                    paymentMethod: PaymentMethod.applePay));
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
  }
}
