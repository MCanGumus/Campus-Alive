import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  final Color textColor;

  RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kSuggestionColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                backgroundColor: MaterialStateProperty.all(color)),
            onPressed: press,
            child: Text(text,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ))),
      ),
    );
  }
}
