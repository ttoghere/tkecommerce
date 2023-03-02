import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tkecommerce/widgets/widgets_shelf.dart';
import '../models/models.dart';


class CategoryCarousel extends StatelessWidget {
  final List<Category> categories;
  const CategoryCarousel({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1.5,
          viewportFraction: 0.9,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: categories //Category Card
            .map((category) => HeroCarouselCard(category: category))
            .toList(),
      ),
    );
  }
}
