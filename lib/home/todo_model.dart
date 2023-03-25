class TodoModel {
  String id;
  String title;
  String content;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'isDone': isDone,
    };
  }
}
