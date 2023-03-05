import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'dart:developer';

class PaymentSelectScreen extends StatelessWidget {
  static const routeName = "/paymentselectscreen";
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
      appBar: const CustomAppBar(title: "Pick Payment M."),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Stripe"),
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
                              log("Google Pay Selected");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : SizedBox(),
                Platform.isIOS
                    ? Column(
                        children: [
                          RawApplePayButton(
                            style: ApplePayButtonStyle.black,
                            type: ApplePayButtonType.inStore,
                            onPressed: () {
                              log("Apple Pay Selected");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
