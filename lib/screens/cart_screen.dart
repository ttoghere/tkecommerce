import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Cart Screen Top Row
                        cartScreenTopRow(state, context),
                        const SizedBox(
                          height: 10,
                        ),
                        //Cart Screen Product List
                        cartScreenProductList(state),
                      ],
                    ),
                    const OrderSummary(),
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

  SizedBox cartScreenProductList(CartLoaded state) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              state.cart.productQuantity(state.cart.products).keys.length,
          itemBuilder: (context, index) {
            return CartProductCard(
              product: state.cart
                  .productQuantity(state.cart.products)
                  .keys
                  .elementAt(index),
              quantity: state.cart
                  .productQuantity(state.cart.products)
                  .values
                  .elementAt(index),
            );
          }),
    );
  }

  Row cartScreenTopRow(CartLoaded state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          state.cart.freeDeliveryString,
          style:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 13),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
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
    );
  }
}
