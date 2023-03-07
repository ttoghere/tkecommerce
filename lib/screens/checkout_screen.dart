
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = "/checkout";
  const CheckoutScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(
        screen: CheckoutScreen.routeName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              var user = state.user ?? User.empty;
              return SingleChildScrollView(
                  child: _checkoutForm(context, state, user));
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  Widget _checkoutForm(BuildContext context, CheckoutLoaded state, User user) {
    return Column(
      children: [
        Text(
          'CUSTOMER INFORMATION',
          style:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
        ),
        CustomTextFormField(
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(email: value)));
            },
            initialValue: user.email,
            context: context,
            label: 'Email'),
        CustomTextFormField(
            initialValue: user.fullName,
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(fullName: value)));
            },
            context: context,
            label: 'Full Name'),
        const SizedBox(height: 20),
        Text(
          'DELIVERY INFORMATION',
          style:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
        ),
        CustomTextFormField(
            initialValue: user.address,
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(address: value)));
            },
            context: context,
            label: 'Address'),
        CustomTextFormField(
            initialValue: user.city,
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(city: value)));
            },
            context: context,
            label: 'City'),
        CustomTextFormField(
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(country: value)));
            },
            context: context,
            initialValue: user.country,
            label: 'Country'),
        CustomTextFormField(
            onChanged: (value) {
              context.read<CheckoutBloc>().add(UpdateCheckout(
                  user: state.checkout.user!.copyWith(zipCode: value)));
            },
            initialValue: user.zipCode,
            context: context,
            label: 'ZIP Code'),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(PaymentSelectScreen.routeName);
                  },
                  child: Text(
                    'SELECT A PAYMENT METHOD',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ORDER SUMMARY',
          style:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
        ),
        const OrderSummary()
      ],
    );
  }
}
