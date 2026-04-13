class Tweet {
  int id;
  int userId;
  String contenido;
  List<int> likes;

  Tweet({
    required this.id,
    required this.userId,
    required this.contenido,
    required this.likes,
  });
}
