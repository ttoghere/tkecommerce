import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';


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
    return Scaffold(
      appBar: const CustomAppBar(title: "Wishlist"),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is WishlistLoaded) {
            var productShorcut = state.wishlist.products;
            return GridView.builder(
              itemCount: productShorcut.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                //Item template for Catalog Screen
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ProductCard(
                    isWishlist: true,
                    product: productShorcut[index],
                    widthFactor: 1.1,
                    leftPosition: 100,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "Something Went Wrong",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }
        },
      ),
    );
  }
}
/*
        

 */