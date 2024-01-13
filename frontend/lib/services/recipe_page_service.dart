import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_world2/DTOs/recipe_ingredient_dto.dart';
import 'package:recipe_world2/DTOs/review_dto.dart';
import '../DTOs/recipe_dto.dart';
import '../controllers/user_controller.dart';

class RecipePageService {
  static Future<Map<String, dynamic>> fetchReviewsDetails(int recipeId) async {
    String reviewApiUrl = "";
    if (Platform.isAndroid) {
      reviewApiUrl = "http://10.0.2.2:8080/api/review/recipe";
    } else {
      reviewApiUrl = "http://localhost:8080/api/review/recipe";
    }

    try {
      final reviewResponse = await http.get(
        Uri.parse("$reviewApiUrl/$recipeId"),
        headers: {"Content-Type": "application/json"},
      );

      if (reviewResponse.statusCode == 200) {
        List<dynamic> reviewJsonList = json.decode(reviewResponse.body);
        List<ReviewDTO> reviewDTO = reviewJsonList.map((json) => ReviewDTO.fromJson(json)).toList();

        return {'reviews': reviewDTO};
      } else {
        return {'reviewError': "Get Review Error: ${reviewResponse.statusCode}"};
      }
    } catch (e) {
      return {'reviewError': "Exception: $e"};
    }
  }

  static Future<Map<String, dynamic>> fetchRecipeDetails(int recipeId) async {
    String recipeApiUrl = "";
    if (Platform.isAndroid) {
      recipeApiUrl = "http://10.0.2.2:8080/api/recipe";
    } else {
      recipeApiUrl = "http://localhost:8080/api/recipe";
    }

    try {
      final recipeResponse = await http.get(
        Uri.parse("$recipeApiUrl/$recipeId"),
        headers: {"Content-Type": "application/json"},
      );

      if (recipeResponse.statusCode == 200) {
        Map<String, dynamic> recipeJson = json.decode(recipeResponse.body);
        RecipeDTO recipeDTO = RecipeDTO.fromJson(recipeJson);

        List<RecipeIngredientDTO> ingredients = recipeDTO.recipeIngredients.map((ingredient) {
          return RecipeIngredientDTO(
              id: ingredient.id,
              name: ingredient.name,
              unit: ingredient.unit,
              quantity: ingredient.quantity
          );
        }).toList();

        return {'recipe': recipeDTO, 'ingredients': ingredients};
      } else {
        return {'recipeError': "Get Recipe Error: ${recipeResponse.statusCode}"};
      }
    } catch (e) {
      return {'recipeError': "Exception: $e"};
    }
  }

  static Future<Map<String, dynamic>> addReview(int recipeId, String comment) async {
    String addReviewApiUrl = "";
    String userId = Get.find<UserController>().userId;

    if (Platform.isAndroid) {
      addReviewApiUrl = "http://10.0.2.2:8080/api/review/add";
    } else {
      addReviewApiUrl = "http://localhost:8080/api/review/add";
    }

    try {
      final response = await http.post(
        Uri.parse(addReviewApiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "recipeId": recipeId,
          "comment": comment,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'error': "Add Review Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }
}