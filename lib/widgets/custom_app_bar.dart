import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets_shelf.dart';
                                                      //Must add this implemeantation
                                                      //For extracting appbar
class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Widget get child => AppBar(
              //Helps to make Gradient Text
        title: GradientText(
                //Takes font types from google_fonts pub
          style: GoogleFonts.aclonica(),
          "TKEcommerce",
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[400]!,
              Colors.white,
              Colors.blue[400]!,
            ],
            stops: const [
              0.0,
              0.5,
              1.0,
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_outlined),
          ),
        ],
      );

  //Preffered size values
  @override
  Size get preferredSize => const Size(20, 35);
}
