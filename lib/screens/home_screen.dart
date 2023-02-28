import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/widgets_shelf.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  HomeScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _imageUrls = [
    "https://static4.depositphotos.com/1004726/350/i/950/depositphotos_3502545-stock-photo-alphabet-block.jpg",
    "https://st2.depositphotos.com/2021995/9294/i/950/depositphotos_92947036-stock-photo-jpeg-concept-wooden-letterpress-type.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Extracted Seperate AppBar in custom_app_bar.dart
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomNavBar(screen: HomeScreen.routeName),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Home',
              style: GoogleFonts.aclonica(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CarouselSlider(
              items: List.generate(
                  _imageUrls.length,
                  (index) => Stack(
                        children: [
                          Image.network(_imageUrls[index]),
                          Positioned(
                              bottom: 10,
                              left: 20,
                              child: Text(index.toString())),
                        ],
                      )),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enlargeCenterPage: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
