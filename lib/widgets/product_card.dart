import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';

class ProductCard extends StatelessWidget {
  const ProductCard.catalog({
    Key? key,
    required this.product,
    this.quantity,
    this.height = 150,
    this.isCatalog = true,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = false,
    this.widthFactor = 1.8,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);
  const ProductCard.cart({
    Key? key,
    required this.product,
    this.quantity,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = true,
    this.isSummary = false,
    this.widthFactor = 2.25,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);
  const ProductCard.wishlist({
    Key? key,
    required this.product,
    this.quantity,
    this.height = 150,
    this.isCatalog = false,
    this.isWishlist = true,
    this.isCart = false,
    this.isSummary = false,
    this.widthFactor = 1.1,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);
  const ProductCard.summary({
    Key? key,
    required this.product,
    this.quantity,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = true,
    this.widthFactor = 2.25,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);
  final Product product;
  final int? quantity;
  final double widthFactor;
  final double height;
  final bool isWishlist;
  final bool isCart;
  final bool isCatalog;
  final bool isSummary;
  final Color iconColor;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double widthValue = width / widthFactor;

    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          Navigator.pushNamed(
            context,
            ProductScreen.routeName,
            arguments: product,
          );
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  ProductImage(
                    widthValue: 100,
                    height: height,
                    product: product,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ProductInformation(
                      product: product,
                      fontColor: fontColor,
                      quantity: quantity,
                      isOrderSummary: isSummary ? true : false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ProductActions(
                    quantity: quantity,
                    product: product,
                    isCatalog: isCatalog,
                    isWishlist: isWishlist,
                    isCart: isCart,
                    iconColor: iconColor,
                  ),
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ProductImage(
                  widthValue: widthValue,
                  product: product,
                  height: height,
                ),
                ProductBackground(
                  widthValue: widthValue,
                  widgets: [
                    ProductInformation(
                      product: product,
                      fontColor: fontColor,
                    ),
                    ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    Key? key,
    required this.product,
    required this.isCatalog,
    required this.isWishlist,
    required this.isCart,
    required this.iconColor,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
              IconButton addProduct = IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: iconColor,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Added to your Cart!'),
                  ));
                  context.read<CartBloc>().add(AddProduct(product));
                },
              );
              IconButton removeProductFromWishlist = IconButton(
                icon: Icon(
                  Icons.delete,
                  color: iconColor,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Removed from your Wishlist!'),
                  ));
                  context
                      .read<WishlistBloc>()
                      .add(RemoveWishlistProduct(product));
                },
              );
              IconButton removeProductFromCart = IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: iconColor,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Removed from your Cart!'),
                  ));
                  context.read<CartBloc>().add(RemoveProduct(product));
                },
              );
              Text productQuantity = Text(
                '$quantity',
                style: Theme.of(context).textTheme.bodyMedium!,
              );
              if (isCatalog) {
                return Row(
                  children: [addProduct],
                );
              }
              if (isWishlist) {
                return Row(
                  children: [addProduct, removeProductFromWishlist],
                );
              }
              if (isCart) {
                return Row(
                  children: [
                    removeProductFromCart,
                    productQuantity,
                    addProduct
                  ],
                );
              } else {
                return const SizedBox();
              }
            } else {
              return Text(
                "Something Went Wrong",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12),
              );
            }
          },
        ),
      ],
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    Key? key,
    required this.product,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: fontColor),
            ),
            Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary
            ? Text(
                "Qty. $quantity",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: fontColor),
              )
            : const SizedBox(),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.widthValue,
    required this.height,
    required this.product,
  }) : super(key: key);

  final double widthValue;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProductBackground extends StatelessWidget {
  final double widthValue;
  final List<Widget> widgets;
  const ProductBackground({
    Key? key,
    required this.widthValue,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthValue - 10,
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: appGradient,
      ),
      child: Container(
        width: widthValue - 20,
        height: 70,
        margin: const EdgeInsets.only(bottom: 5),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
