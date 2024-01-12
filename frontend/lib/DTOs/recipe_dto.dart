import 'package:recipe_world2/DTOs/user_dto.dart';

import 'category_dto.dart';
import 'recipe_ingredient_dto.dart';

class RecipeDTO {
  int id;
  String title;
  String description;
  int prepTime;
  DateTime date;
  CategoryDTO category;
  UserDTO author;
  List<RecipeIngredientDTO> recipeIngredients;

  RecipeDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.prepTime,
    required this.date,
    required this.category,
    required this.author,
    required this.recipeIngredients,
  });

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    return RecipeDTO(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      prepTime: json['prepTime'],
      date: DateTime.parse(json['date']),
      category: CategoryDTO.fromJson(json['category']),
      author: UserDTO.fromJson(json['author']),
      recipeIngredients: (json['recipeIngredients'] as List<dynamic>?)
          ?.map((ingredientJson) =>
          RecipeIngredientDTO.fromJson(ingredientJson))
          .toList() ?? [],
    );
  }
}