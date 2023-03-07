// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/cubits/sign_up/sign_up_cubit.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(title: "Sign Up"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(email: value));
                    },
                    labelText: "Email",
                  ),
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(fullName: value));
                    },
                    labelText: "Full Name",
                  ),
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(country: value));
                    },
                    labelText: "Country",
                  ),
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(city: value));
                    },
                    labelText: "City",
                  ),
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(address: value));
                    },
                    labelText: "Address",
                  ),
                  _UserInput(
                    onChanged: (value) {
                      context
                          .read<SignUpCubit>()
                          .userChanged(state.user!.copyWith(zipCode: value));
                    },
                    labelText: "Zip Code",
                  ),
                  _PasswordInput(),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignUpCubit>().signUpWithCredentials();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(200, 50),
                    ),
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  final Function(String)? onChanged;
  final String labelText;
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(labelText: labelText),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
              onChanged: (password) {
                context.read<SignUpCubit>().passwordChanged(password);
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
