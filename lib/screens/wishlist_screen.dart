import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/wishlist";
  const WishlistScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
