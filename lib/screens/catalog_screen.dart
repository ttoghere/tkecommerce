import 'package:flutter/material.dart';
import 'package:tkecommerce/app_shelf.dart';

class CatalogScreen extends StatelessWidget {
  static const routeName = "/catalog";
  final Category category;
  const CatalogScreen({super.key, required this.category});
  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((element) => element.category == category.name)
        .toList();
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Category",
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: GridView.builder(
        itemCount: 3,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.15),
        itemBuilder: (context, index) {
          //Item template for Catalog Screen
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ProductCard.catalog(
              product: categoryProducts[index],
            ),
          );
        },
      ),
    );
  }
}
