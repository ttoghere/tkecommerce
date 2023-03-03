import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/blocs_shelf.dart';
import 'package:tkecommerce/blocs/cart/cart_bloc.dart';
import 'package:tkecommerce/config/consts.dart';
import 'package:tkecommerce/models/product_model.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';
import 'package:tkecommerce/widgets/widgets_shelf.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product";
  final Product product;
  const ProductScreen({super.key, required this.product});
  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ProductScreen(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              return IconButton(
                onPressed: () {
                  context.read<WishlistBloc>().add(AddWishlistProduct(product));
                  final SnackBar snackBar = SnackBar(
                      content:
                          Text("A ${product.name} has been added to wishlist"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red[900],
                ),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddProduct(product));
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: [HeroCarouselCard(product: product)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(gradient: appGradient),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width - 10,
                        height: 50,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$${product.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      "Product Information",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          "Lorem" * 40,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Delivery Information",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          "Lorem" * 40,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
