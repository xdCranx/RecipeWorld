import 'ingredient.dart';
class Recipe {
  int id;
  String title;
  String description;
  int category_id;
  int author_id;
  DateTime date;
  List<String> ingredients;
  //add preptime

  Recipe({required this.id, required this.title, required this.description, required this.category_id, required this.author_id, required this.date, List<String>? ingredients}): ingredients = ingredients ?? [];
}
