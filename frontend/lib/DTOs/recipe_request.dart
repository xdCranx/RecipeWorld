import 'package:tuple/tuple.dart';

class RecipeRequest {
  final String userId;
  final int categoryId;
  final String title;
  final String description;
  final List<Tuple2<int, int>> ingredients;
  //first is id and second is quantity
  final int prepTime;

  RecipeRequest({
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.prepTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'ingredients': ingredients.map((tuple) => {'first': tuple.item1, 'second': tuple.item2}).toList(),
      'prepTime': prepTime,
    };
  }
}