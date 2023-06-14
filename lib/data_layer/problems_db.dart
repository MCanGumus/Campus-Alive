class Problems {
  int pk;
  String title;
  String text;
  int retweetCount;
  String? photoPath;
  int importance;
  int userFK;

  Problems(
      {required this.pk,
      required this.title,
      required this.text,
      required this.retweetCount,
      this.photoPath,
      required this.userFK,
      required this.importance});
}
