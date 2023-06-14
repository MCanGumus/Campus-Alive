import 'dart:io';

import '../data_layer/suggestions_db.dart';
import '../db_helper.dart';

class SuggestionDAO {
  Future<List<Suggestions>> getSuggestions() async {
    var db = await DatabaseHelper.dbConnect();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Suggestions");

    return List.generate(maps.length, (i) {
      var column = maps[i];
      return Suggestions(
        pk: column["PK"],
        title: column["Title"],
        text: column["Text"],
        retweetCount: column["Retweet_Count"],
        userFK: column["User_FK"],
      );
    });
  }

  Future<void> addSuggestion(
    int userFK,
    String title,
    String text,
  ) async {
    var db = await DatabaseHelper.dbConnect();

    var infos = Map<String, dynamic>();

    infos["Title"] = title;
    infos["Text"] = text;
    infos["Retweet_Count"] = 0;
    infos["User_FK"] = userFK;

    await db.insert("Suggestions", infos);
  }
}
