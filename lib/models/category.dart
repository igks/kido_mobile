part of 'models.dart';

class Category {
  late int id;
  late String name;
  String? description;

  Category({required this.id, required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json['id'], name: json['name'], description: json['description']);
}
