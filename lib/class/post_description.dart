class PostDescription {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostDescription({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDescription.fromJson(Map<String, dynamic> json) {
    return PostDescription(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
