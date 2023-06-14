import 'package:destek_ve_sikayet_portali/db_helper.dart';

import '../data_layer/users_db.dart';

class UserDAO {
  Future<List<Users>> getUsers() async {
    var db = await DatabaseHelper.dbConnect();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM Users");

    return List.generate(maps.length, (i) {
      var column = maps[i];
      return Users(
          pk: column["PK"],
          nameSurname: column["Name_Surname"],
          email: column["EMail"],
          password: column["Password"],
          profilePhoto: column["Profile_Photo_Path"]);
    });
  }

  Future<void> addUser(
    String nameSurname,
    String email,
    String password,
  ) async {
    var db = await DatabaseHelper.dbConnect();

    var infos = Map<String, dynamic>();

    infos["Name_Surname"] = nameSurname;
    infos["EMail"] = email;
    infos["Password"] = password;

    await db.insert("Users", infos);
  }

  Future<bool> checkEmailExists(String email) async {
    var db = await DatabaseHelper.dbConnect();
    var result = await db.query(
      "Users",
      where: "EMail = ?",
      whereArgs: [email],
    );

    return result.isNotEmpty;
  }

  Future<Users?> findUser(String email, String password) async {
    var db = await DatabaseHelper.dbConnect();

    var users = await db.query(
      "Users",
      where: "EMail = ? AND Password = ?",
      whereArgs: [email, password],
      limit: 1,
    );

    if (users.isNotEmpty) {
      var userMap = Map<String, dynamic>.from(users.first);
      return Users(
        pk: userMap["PK"],
        nameSurname: userMap["Name_Surname"] as String,
        email: userMap["EMail"] as String,
        password: userMap["Password"] as String,
      );
    }

    return null;
  }

  Future<Users?> findUserWithPk(int pk) async {
    var db = await DatabaseHelper.dbConnect();

    var users = await db.query(
      "Users",
      where: "PK = ?",
      whereArgs: [pk],
      limit: 1,
    );

    if (users.isNotEmpty) {
      var userMap = Map<String, dynamic>.from(users.first);
      return Users(
        pk: userMap["PK"],
        nameSurname: userMap["Name_Surname"] as String,
        email: userMap["EMail"] as String,
        password: userMap["Password"] as String,
      );
    }

    return null;
  }
}
