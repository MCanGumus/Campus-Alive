import 'package:destek_ve_sikayet_portali/Home/home_page.dart';
import 'package:destek_ve_sikayet_portali/Problem/Report/report_a_problem.dart';
import 'package:destek_ve_sikayet_portali/Problem/problems_page.dart';
import 'package:destek_ve_sikayet_portali/Suggestion/Give/give_a_suggestion.dart';
import 'package:destek_ve_sikayet_portali/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'Suggestion/suggestion_page.dart';
import 'content_details_page/content_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Campus Alive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProblemsPage(
          userFK: 1,
        ));
  }
}
