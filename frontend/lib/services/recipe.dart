import 'ingredient.dart';
class IngVal {
  Ingredient ingredient;
  int qty;

  IngVal({required this.ingredient, required this.qty});
}

class Recipe {
  int id;
  String title;
  String description;
  int category_id;
  int author_id;
  DateTime date;
  List<IngVal> ingredients;
  int? preptime;

  Recipe({required this.id, required this.title, required this.description, required this.category_id, required this.author_id, required this.date,required this.preptime, List<IngVal>? ingredients}): ingredients = ingredients ?? [];
}
