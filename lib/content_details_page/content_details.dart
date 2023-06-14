import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ContentDetailsPage extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String text;
  final int interactionCount;
  final int? importance;
  final String authorName;
  final String contentType;

  ContentDetailsPage({
    required this.imagePath,
    required this.title,
    required this.text,
    required this.interactionCount,
    required this.importance,
    required this.authorName,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight / 3;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'İçerik',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: contentType == "Problem"
                  ? kProblemColor
                  : (contentType == "Suggestion"
                      ? kSuggestionColor
                      : kEventColor)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: imagePath == "" ? 0 : 15),
              child: imagePath == ""
                  ? null
                  : Container(
                      height: containerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: imagePath == ""
                            ? null
                            : Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "   " + text,
                    style: GoogleFonts.montserrat(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  Row(
                    children: [
                      contentType == "Problem"
                          ? Icon(
                              Icons.repeat,
                              color: kProblemColor,
                            )
                          : (contentType == "Suggestion"
                              ? Icon(
                                  Icons.favorite,
                                  color: kSuggestionLightColor,
                                )
                              : Icon(
                                  Icons.repeat,
                                  color: kProblemColor,
                                )),
                      Text(
                        interactionCount.toString(),
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                      Spacer(),
                      if (contentType == "Problem")
                        Text(
                          "Önemlilik Derecesi ",
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 16),
                        ),
                      if (contentType == "Problem")
                        Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                              color: importance == 1
                                  ? Colors.green.withOpacity(1)
                                  : (importance == 2
                                      ? Colors.yellow.withOpacity(1)
                                      : Colors.red.withOpacity(1)),
                              shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage("assets/images/cangumus.jpg"),
                      ),
                      SizedBox(width: 8),
                      Text(
                        authorName,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
