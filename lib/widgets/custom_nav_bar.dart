// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tkecommerce/app_shelf.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: (screen == ProductScreen.routeName)
            ? AddToCartNavBar(product: product!)
            : (screen == CartScreen.routeName)
                ? const GoToCheckoutNavBar()
                : (screen == CheckoutScreen.routeName)
                    ? const OrderNavBar()
                    : const HomeNavBar(),
      ),
    );
  }

  // //Switch Case Statement is a useful changer in app
  // //it changes the options with parameters
  // List<Widget>? _selectNavBar(context, screen) {
  //   switch (screen) {
  //     case HomeScreen.routeName:
  //       return _buildNavBar(context);
  //     case CatalogScreen.routeName:
  //       return _buildNavBar(context);
  //     case WishlistScreen.routeName:
  //       return _buildNavBar(context);
  //     case ProductScreen.routeName:
  //       return _buildProductNavBar(context);
  //     case CartScreen.routeName:
  //       return _buildGoToCheckoutNavBar(context);
  //     case CheckoutScreen.routeName:
  //       return _buildGoToOrderNavBar(context);
  //     case OrderConfirmationScreen.routeName:
  //       return _buildOrderConfirmation(context);
  //     case PaymentSelectScreen.routeName:
  //       return _buildGoToCheckoutNavBar(context);
  //   }
  //   return _buildNavBar(context);
  // }

  // List<Widget> _buildGoToOrderNavBar(context) {
  //   return [
  //     BlocBuilder<CheckoutBloc, CheckoutState>(
  //       builder: (context, state) {
  //         if (state is CheckoutLoading) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else if (state is CheckoutLoaded) {
  //           if (Platform.isIOS) {
  //             switch (state.paymentMethod) {
  //               case PaymentMethod.applePay:
  //                 return ApplePay(
  //                   products: state.products!,
  //                   total: state.total!,
  //                 );
  //               case PaymentMethod.creditCard:
  //                 return Container();
  //               default:
  //                 return ApplePay(
  //                   products: state.products!,
  //                   total: state.total!,
  //                 );
  //             }
  //           }
  //           if (Platform.isAndroid) {
  //             switch (state.paymentMethod) {
  //               case PaymentMethod.googlePay:
  //                 return GooglePay(
  //                   products: state.products!,
  //                   total: state.total!,
  //                 );
  //               case PaymentMethod.creditCard:
  //                 return Container();
  //               default:
  //                 return GooglePay(
  //                   products: state.products!,
  //                   total: state.total!,
  //                 );
  //             }
  //           } else {
  //             return ElevatedButton(
  //                 onPressed: () {}, child: const Text("Payment Selection"));
  //           }
  //         } else {
  //           return const Center(child: Text("Something is wrong"));
  //         }
  //       },
  //     )
  //   ];
  // }

  // List<Widget> _buildProductNavBar(context) {
  //   return [
  //     IconButton(
  //       onPressed: () {},
  //       icon: const Icon(
  //         Icons.share,
  //         color: Colors.white,
  //       ),
  //     ),
  //     BlocBuilder<WishlistBloc, WishlistState>(
  //       builder: (context, state) {
  //         if (state is WishlistLoading) {
  //           return const CircularProgressIndicator();
  //         }
  //         if (state is WishlistLoaded) {
  //           return IconButton(
  //             onPressed: () {
  //               const snackbar =
  //                   SnackBar(content: Text("Added To Your Wishlist!!"));
  //               ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //               context.read<WishlistBloc>().add(
  //                     AddWishlistProduct(product!),
  //                   );
  //             },
  //             icon: Icon(
  //               Icons.favorite_border_outlined,
  //               color: Colors.red[900],
  //             ),
  //           );
  //         } else {
  //           return const Text("Something went wrong");
  //         }
  //       },
  //     ),
  //     BlocBuilder<CartBloc, CartState>(
  //       builder: (context, state) {
  //         if (state is CartLoading) {
  //           return const CircularProgressIndicator();
  //         }
  //         if (state is CartLoaded) {
  //           return ElevatedButton(
  //             onPressed: () {
  //               context.read<CartBloc>().add(AddProduct(product!));
  //               Navigator.of(context).pushNamed(CartScreen.routeName);
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.blue[900],
  //             ),
  //             child: Text(
  //               "Add To Cart",
  //               style: Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                     fontSize: 15,
  //                   ),
  //             ),
  //           );
  //         } else {
  //           return const Text("Something Went Wrong");
  //         }
  //       },
  //     ),
  //   ];
  // }

  // List<Widget> _buildGoToCheckoutNavBar(context) {
  //   return [];
  // }

  // List<Widget>? _buildOrderConfirmation(context) {
  //   return [
  //     ElevatedButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, HomeScreen.routeName);
  //       },
  //       style: ElevatedButton.styleFrom(
  //         shadowColor: Colors.white,
  //         backgroundColor: Colors.grey[900],
  //         side: const BorderSide(
  //           width: 2,
  //           color: Colors.white,
  //         ),
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(
  //               20,
  //             ),
  //           ),
  //         ),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: GradientText(
  //           "Go To Shopping",
  //           gradient: appGradient,
  //           style: const TextStyle(
  //             fontSize: 25,
  //           ),
  //         ),
  //       ),
  //     ),
  //   ];
  // }

  // List<Widget>? _buildPayMethodPick(context) {
  //   return [
  //     BlocBuilder<CheckoutBloc, CheckoutState>(
  //       builder: (context, state) {
  //         if (state is CheckoutLoading) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if (state is CheckoutLoaded) {
  //           // ApplePay();
  //           return ElevatedButton(
  //             onPressed: () {
  //               context
  //                   .read<CheckoutBloc>()
  //                   .add(ConfirmCheckout(checkout: state.checkout));
  //               Navigator.of(context)
  //                   .pushNamed(OrderConfirmationScreen.routeName);
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.blue[900],
  //             ),
  //             child: Text(
  //               "Order Now ",
  //               style: Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                     fontSize: 15,
  //                   ),
  //             ),
  //           );
  //         } else {
  //           return const Center(
  //             child: Text("Something Went Wrong"),
  //           );
  //         }
  //       },
  //     ),
  //   ];
  // }
}

class AddToCartNavBar extends StatelessWidget {
  final Product? product;
  const AddToCartNavBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CircularProgressIndicator();
            }
            if (state is WishlistLoaded) {
              return IconButton(
                onPressed: () {
                  const snackbar =
                      SnackBar(content: Text("Added To Your Wishlist!!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  context.read<WishlistBloc>().add(
                        AddWishlistProduct(product!),
                      );
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red[900],
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const CircularProgressIndicator();
            }
            if (state is CartLoaded) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddProduct(product!));
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text(
                  "Add To Cart",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 15,
                      ),
                ),
              );
            } else {
              return const Text("Something Went Wrong");
            }
          },
        ),
      ],
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          onPressed: () {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
        )
      ],
    );
  }
}

class OrderNavBar extends StatelessWidget {
  const OrderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.creditCard) {
                return SizedBox(
                  child: Text(
                    "Pay With Credit Card",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                );
              }
              if (Platform.isIOS &&
                  state.paymentMethod == PaymentMethod.applePay) {
                return ApplePay(
                  products: state.products!,
                  total: state.total!,
                );
              }
              if (Platform.isAndroid &&
                  state.paymentMethod == PaymentMethod.googlePay) {
                return GooglePay(
                  products: state.products!,
                  total: state.total!,
                );
              } else {
                return ElevatedButton(
                    onPressed: () {}, child: const Text("Payment Selection"));
              }
            } else {
              return const Center(child: Text("Something is wrong"));
            }
          },
        )
      ],
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}
