import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = "/orderconfirmation";
  const OrderConfirmationScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmationScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
