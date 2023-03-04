import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:tkecommerce/screens/order_confirmation_screen.dart';
import 'package:tkecommerce/screens/payment_select_screen.dart';
import 'package:tkecommerce/widgets/widgets_shelf.dart';

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
        child: checkoutForm(),
      ),
    );
  }

  BlocBuilder<CheckoutBloc, CheckoutState> checkoutForm() {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CheckoutLoaded) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CUSTOMER INFORMATION',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18),
                ),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(email: value));
                    },
                    context: context,
                    label: 'Email'),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(fullName: value));
                    },
                    context: context,
                    label: 'Full Name'),
                const SizedBox(height: 20),
                Text(
                  'DELIVERY INFORMATION',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18),
                ),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(address: value));
                    },
                    context: context,
                    label: 'Address'),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(city: value));
                    },
                    context: context,
                    label: 'City'),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(country: value));
                    },
                    context: context,
                    label: 'Country'),
                CustomTextFormField(
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(zipCode: value));
                    },
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
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18),
                ),
                const OrderSummary()
              ],
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
