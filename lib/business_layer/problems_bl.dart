import 'dart:io';

import 'package:destek_ve_sikayet_portali/Problem/Report/report_a_problem.dart';
import 'package:destek_ve_sikayet_portali/data_layer/problems_db.dart';
import 'package:destek_ve_sikayet_portali/db_helper.dart';

class ProblemDAO {
  Future<List<Problems>> getProblems() async {
    var db = await DatabaseHelper.dbConnect();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Problems");

    return List.generate(maps.length, (i) {
      var column = maps[i];
      return Problems(
          pk: column["PK"],
          title: column["Title"],
          text: column["Text"],
          retweetCount: column["Retweet_Count"],
          userFK: column["User_FK"],
          photoPath: column["Photo_Path"],
          importance: column["Importance"]);
    });
  }

  Future<void> addProblem(int userFK, String title, String text,
      bool isAnonymous, String selectedImage, int importanceLevel) async {
    var db = await DatabaseHelper.dbConnect();

    var infos = Map<String, dynamic>();

    infos["Title"] = title;
    infos["Text"] = text;
    infos["Anonymous"] = isAnonymous == 1 ? 1 : 0;
    infos["Importance"] = importanceLevel;
    infos["Retweet_Count"] = 0;
    infos["Photo_Path"] = selectedImage;
    infos["User_FK"] = userFK;

    await db.insert("Problems", infos);
  }
}
