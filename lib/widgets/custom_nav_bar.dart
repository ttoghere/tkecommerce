import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/config/consts.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';
import 'package:tkecommerce/widgets/gradient_text.dart';

import '../blocs/blocs_shelf.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;

  const CustomNavBar({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  //Switch Case Statement is a useful changer in app
  //it changes the options with parameters
  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case HomeScreen.routeName:
        return _buildNavBar(context);
      case CatalogScreen.routeName:
        return _buildNavBar(context);
      case WishlistScreen.routeName:
        return _buildNavBar(context);
      case ProductScreen.routeName:
        return _buildProductNavBar(context);
      case CartScreen.routeName:
        return _buildGoToCheckoutNavBar(context);
      case CheckoutScreen.routeName:
        return _buildGoToOrderNavBar(context);
    }
    return _buildNavBar(context);
  }

  List<Widget> _buildGoToOrderNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            return ElevatedButton(
              onPressed: () {
                context
                    .read<CheckoutBloc>()
                    .add(ConfirmCheckout(checkout: state.checkout));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
              ),
              child: Text(
                "Order Now ",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
    ];
  }

  List<Widget> _buildProductNavBar(context) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {
          context.read<WishlistBloc>();
        },
        icon: Icon(
          Icons.favorite_border_outlined,
          color: Colors.red[900],
        ),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
        ),
        child: Text(
          "Add To Cart",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 15,
              ),
        ),
      ),
    ];
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
      ),
      IconButton(
        icon: const Icon(Icons.person, color: Colors.white),
        onPressed: () {},
      )
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, CheckoutScreen.routeName);
        },
        style: OutlinedButton.styleFrom(
          shadowColor: Colors.white,
          backgroundColor: Colors.grey[900],
          side: const BorderSide(
            width: 2,
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GradientText(
            "Go To Checkout",
            gradient: appGradient,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    ];
  }
}
