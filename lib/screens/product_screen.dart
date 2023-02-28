import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product";
  const ProductScreen({super.key});  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ProductScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
