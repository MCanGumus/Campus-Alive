class Users {
  int pk;
  String nameSurname;
  String email;
  String password;
  String? profilePhoto;

  Users({
    required this.pk,
    required this.nameSurname,
    required this.email,
    required this.password,
    this.profilePhoto,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      nameSurname: map["Name_Surname"],
      email: map["EMail"],
      password: map["Password"],
      pk: map["PK"],
    );
  }
}
