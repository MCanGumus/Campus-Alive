import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class SocialIcon extends StatelessWidget {
  final String src;
  final Function press;
  const SocialIcon({super.key, required this.src, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //onTap: press
        child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: kEventColor),
          shape: BoxShape.circle),
      child: SvgPicture.asset(
        src,
        height: 20,
        width: 20,
      ),
    ));
  }
}
