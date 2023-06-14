import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../content_details_page/content_details.dart';

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
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContentDetailsPage(
                title: title,
                text: text,
                imagePath: imgAssetName,
                authorName: name,
                importance: important,
                interactionCount: retweetCount,
                contentType: "Suggestion",
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title.length >= 30 ? title.substring(0, 30) + '...' : title,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: size.height * 0.001),
              Divider(),
              SizedBox(height: size.height * 0.01),
              Text(
                text.length >= 150 ? text.substring(0, 150) + '...' : text,
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
                        color: kSuggestionColor,
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/cangumus.jpg'),
                      //backgroundImage: AssetImage('images/' + imgAssetName),
                    ),
                  ),
                  Text(
                    " " + name,
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
                      color: kSuggestionColor,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: kSuggestionLightColor,
                  ),
                  SizedBox(width: size.width * 0.01),
                ],
              ),
            ],
          ),
        ));
  }
}
