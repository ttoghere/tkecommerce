import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/signup";
  const SignUpScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SignUpScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
