part of 'models.dart';

class Content {
  late int id;
  late int titleId;
  late String mantram;
  late String meaning;
  String? description;

  Content(
      {required this.id,
      required this.titleId,
      required this.mantram,
      required this.meaning,
      this.description});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      id: json['id'],
      titleId: json['title_id'],
      mantram: json['content'],
      meaning: json['meaning'],
      description: json['description']);
}
