import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/DTOs/user_dto.dart';

class ReviewDTO {
  int id;
  String comment;
  RecipeDTO recipe;
  UserDTO user;

  ReviewDTO({
    required this.id,
    required this.comment,
    required this.recipe,
    required this.user
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) {
    return ReviewDTO(
      id: json['id'],
      comment: json['comment'],
      recipe: RecipeDTO.fromJson(json['recipe']),
      user: UserDTO.fromJson(json['user'])
    );
  }
}