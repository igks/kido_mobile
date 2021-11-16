part of 'models.dart';

class Title {
  late int id;
  late int categoryId;
  String content;

  Title({required this.id, required this.categoryId, required this.content});

  factory Title.fromJson(Map<String, dynamic> json) => Title(
      id: json['id'], categoryId: json['category_id'], content: json['title']);
}
