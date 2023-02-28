import 'package:flutter/material.dart';

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
    return const Placeholder();
  }
}
