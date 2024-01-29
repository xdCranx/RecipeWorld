import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';
import 'package:recipe_world2/DTOs/ingredient.dart';

import '../DTOs/recipe_request.dart';

class AddRecipeController extends GetxController {
  RxList<Ingredient> listOfIngredients = <Ingredient>[].obs;
  RxList<CategoryDTO> listOfCategories = <CategoryDTO>[].obs;
  RxList<Ingredient> listOfAddedIngredients = <Ingredient>[].obs;


  late String apiUrl = Platform.isAndroid
      ? "http://10.0.2.2:8080/api"
      : "http://localhost:8080/api";

  AddRecipeController() {
    getIngredients();
    getCategories();
  }

  Future<void> getIngredients() async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/ingredients"),
      );

      if (response.statusCode == 200) {
        List<dynamic> ingredientsJsonList = jsonDecode(response.body);
        List<Ingredient> ingredients = ingredientsJsonList.map((json) =>
            Ingredient.fromJson(json)).toList();
        listOfIngredients.assignAll(ingredients);
      } else {
        throw Exception("Response error:${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/category"),
      );

      if (response.statusCode == 200) {
        List<dynamic> categoriesJsonList = jsonDecode(response.body);
        List<CategoryDTO> categories = categoriesJsonList.map((json) =>
            CategoryDTO.fromJson(json)).toList();
        listOfCategories.assignAll(categories);
      } else {
        throw Exception("Response error:${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> addRecipe({
    required String userId,
    required int categoryId,
    required String title,
    required String description,
    required List<Map<String, dynamic>> ingredients,
    required int prepTime,
  }) async {
    try {
      RecipeRequest recipeRequest = RecipeRequest(
        userId: userId,
        categoryId: categoryId,
        title: title,
        description: description,
        ingredients: ingredients,
        prepTime: prepTime,
      );

      Map<String, dynamic> requestBody = recipeRequest.toJson();


      final response = await http.post(
        Uri.parse('$apiUrl/recipe'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Recipe added successfully!');
      } else {
        print('Error adding recipe: ${response.statusCode}');
      }
    } catch (e) {

      print('Error: $e');
    }
  }

  void updateIngredientLists(Ingredient ingredient){
    listOfIngredients.remove(ingredient);
    listOfAddedIngredients.add(ingredient);
  }

}