import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/app_shelf.dart';

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
            categoryCarouselBloc(),
            //Search Field
            const SearchBox(),
            //Section Title
            const SectionTile(
              title: "Recommended",
            ),
            //Recommended Product Carousel
            recommendedProductCarouselBloc(),
            //Section Title
            const SectionTile(
              title: "Popular",
            ),
            //Popular Product Carousel
            popularProductCarouselBloc(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ProductBloc, ProductState> popularProductCarouselBloc() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          return ProductCarousel(
            products:
                state.products.where((element) => element.isPopular).toList(),
          );
        } else {
          return const Text("Something Went Wrong");
        }
      },
    );
  }

  BlocBuilder<ProductBloc, ProductState> recommendedProductCarouselBloc() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          return ProductCarousel(
            products: state.products
                .where((element) => element.isRecommended)
                .toList(),
          );
        } else {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
      },
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> categoryCarouselBloc() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryLoaded) {
          return CategoryCarousel(
            categories: state.categories,
          );
        } else {
          return Center(
            child: Text(
              "Something Went Wrong",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
      },
    );
  }
}
