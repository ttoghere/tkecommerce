// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/cart/cart_bloc.dart';
import 'package:tkecommerce/models/models.dart';

import 'package:tkecommerce/models/product_model.dart';
import 'package:tkecommerce/screens/home_screen.dart';
import 'package:tkecommerce/widgets/custom_app_bar.dart';
import 'package:tkecommerce/widgets/widgets_shelf.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cartscreen";
  const CartScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Cart"),
      bottomNavigationBar: const CustomNavBar(screen: CartScreen.routeName),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.cart.freeDeliveryString,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 13),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(HomeScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                              ),
                              child: Text(
                                "Add More Items",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cart.products.length,
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                    product: state.cart.products[index]);
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$${state.cart.subtotalString}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Fee:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$${state.cart.deliveryFeeString}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(50),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$${state.cart.totalString}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
