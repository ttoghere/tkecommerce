import 'package:flutter/material.dart';
import 'package:tkecommerce/models/models.dart';
import '../widgets/widgets_shelf.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Extracted Seperate AppBar in custom_app_bar.dart
      appBar: const CustomAppBar(
        title: "TKEcommerce",
      ),
      bottomNavigationBar: const CustomNavBar(screen: HomeScreen.routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Category Carousel
            CategoryCarousel(
              categories: Category.categories,
            ),
            //Section Title
            const SectionTile(
              title: "Recommended",
            ),
            //Recommended Product Carousel
            ProductCarousel(
              products: Product.products
                  .where((element) => element.isRecommended)
                  .toList(),
            ),
            //Section Title
            const SectionTile(
              title: "Popular",
            ),
            //Popular Product Carousel
            ProductCarousel(
              products: Product.products
                  .where((element) => element.isPopular)
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
