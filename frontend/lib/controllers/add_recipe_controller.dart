import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';
import 'package:recipe_world2/DTOs/ingredient.dart';
import 'package:tuple/tuple.dart';

import '../DTOs/recipe_request.dart';

class AddRecipeController extends GetxController {
  RxList<Ingredient> listOfIngredients = <Ingredient>[].obs;
  RxList<CategoryDTO> listOfCategories = <CategoryDTO>[].obs;
  RxList<Ingredient> listOfAddedIngredients = <Ingredient>[].obs;
  CategoryDTO? chosenCategory;
  RxList<Tuple2<int, double>> listOfIngredientAndQuantities =
      <Tuple2<int, double>>[].obs;

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
        List<Ingredient> ingredients = ingredientsJsonList
            .map((json) => Ingredient.fromJson(json))
            .toList();
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
        List<CategoryDTO> categories = categoriesJsonList
            .map((json) => CategoryDTO.fromJson(json))
            .toList();
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
    required List<Tuple2<int, double>> ingredients,
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
        Get.close(1);
        Get.snackbar(
          "Yay!",
          "Your recipe has been added",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.grey[200],
          backgroundColor: Colors.grey[400],
          backgroundGradient: LinearGradient(
            colors: [
              Colors.green.shade500.withOpacity(0.5),
              Colors.green,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'];
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.grey[200],
          backgroundColor: Colors.grey[400],
          backgroundGradient: LinearGradient(
            colors: [Colors.purple.withOpacity(0.7), Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateIngredientLists(Ingredient ingredient) {
    listOfIngredients.remove(ingredient);
    listOfAddedIngredients.add(ingredient);
  }

  void updateIngredientQuantities(int ingredientId, double quantity) {
    int existingIndex = listOfIngredientAndQuantities.indexWhere(
      (tuple) => tuple.item1 == ingredientId,
    );
    if (existingIndex != -1) {
      listOfIngredientAndQuantities[existingIndex] =
          Tuple2(ingredientId, quantity);
    } else {
      listOfIngredientAndQuantities.add(Tuple2(ingredientId, quantity));
    }
  }
}
