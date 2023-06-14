class Suggestions {
  int pk;
  String title;
  String text;
  int retweetCount;
  int userFK;

  Suggestions({
    required this.pk,
    required this.title,
    required this.text,
    required this.retweetCount,
    required this.userFK,
  });
}
