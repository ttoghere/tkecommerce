// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tkecommerce/config/consts.dart';
import 'package:tkecommerce/screens/screens_shelf.dart';

import 'widgets_shelf.dart';

//Must add this implemeantation
//For extracting appbar
class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //Helps to make Gradient Text
      title: gradientTitle(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          splashColor: Colors.transparent,
          splashRadius: 0.1,
          onPressed: () {
            Navigator.of(context).pushNamed(WishlistScreen.routeName);
          },
          icon: Icon(
            Icons.favorite_rounded,
            color: Colors.red[900]!,
          ),
        ),
      ],
    );
  }

  Container gradientTitle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: GradientText(
        //Takes font types from google_fonts pub
        style: GoogleFonts.aclonica(),
        title,
        gradient: appGradient,
      ),
    );
  }

  //Preffered size values
  @override
  Size get preferredSize => const Size(20, 48);

  @override
  // TODO: implement child
  Widget get child => Container();
}
