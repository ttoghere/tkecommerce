import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/blocs/cart/cart_bloc.dart';
import 'package:tkecommerce/config/consts.dart';
import 'package:tkecommerce/models/models.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;
  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductScreen.routeName, arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            SizedBox(
              width: widthValue,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 65,
              left: leftPosition,
              child: Container(
                width: widthValue - 5 - leftPosition,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38,
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: leftPosition + 5,
              child: Container(
                width: widthValue - 15 - leftPosition,
                height: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: appGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: cardInformation(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row cardInformation(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 13),
              ),
              Text(
                "\$${product.price}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              return Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddProduct(product));
                  },
                  icon: const Icon(
                    Icons.add_circle,
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
        isWishlist
            ? BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CartLoaded) {
                    return Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveProduct(product));
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
