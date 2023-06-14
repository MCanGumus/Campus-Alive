import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String text;
  final int retweetCount;
  final String name;
  final int important;
  final String imgAssetName;
  CardWidget({
    required this.title,
    required this.text,
    required this.retweetCount,
    required this.name,
    required this.important,
    required this.imgAssetName,
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
              Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                    color: important == 3
                        ? Colors.green.withOpacity(1)
                        : Colors.green.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                    color: important == 2
                        ? Colors.yellow.withOpacity(1)
                        : Colors.yellow.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                    color: important == 1
                        ? Colors.red.withOpacity(1)
                        : Colors.red.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),
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
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kProblemColor,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/cangumus.jpg'),
                  //backgroundImage: AssetImage('images/' + imgAssetName),
                ),
              ),
              SizedBox(width: 8.0),
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
                  color: kProblemColor,
                ),
              ),
              Icon(
                Icons.repeat,
                color: kProblemColor,
              ),
              SizedBox(width: size.width * 0.01),
            ],
          ),
        ],
      ),
    );
  }
}
