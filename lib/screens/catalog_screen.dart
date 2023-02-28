import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  static const routeName = "/catalog";
  const CatalogScreen({super.key});  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CatalogScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
