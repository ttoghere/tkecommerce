import 'package:flutter/material.dart';
import 'package:tkecommerce/app_shelf.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  const ProductCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 170,
      child: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          //Product Card
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ProductCard.catalog(
              product: products[index],
            ),
          );
        },
      ),
    );
  }
}
