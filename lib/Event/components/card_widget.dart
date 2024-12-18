import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String text;
  final int retweetCount;
  final String name;
  final int important;

  CardWidget({
    required this.title,
    required this.text,
    required this.retweetCount,
    required this.name,
    required this.important,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: size.height * 0.001),
          Divider(),
          SizedBox(height: size.height * 0.01),
          Text(
            text,
            style: GoogleFonts.montserrat(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Divider(),
          SizedBox(height: 1.0),
          Row(
            children: [
              Text(
                name,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              Text(
                retweetCount.toString(),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: kEventColor,
                ),
              ),
              Icon(
                Icons.add_location,
                color: kEventColor,
              ),
              SizedBox(width: size.width * 0.01),
            ],
          ),
        ],
      ),
    );
  }
}
