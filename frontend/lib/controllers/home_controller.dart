import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../DTOs/recipe_dto.dart';

class HomeController extends GetxController {
  RxList<RecipeDTO> listOfRecipes = <RecipeDTO>[].obs;
  late String apiUrl = Platform.isAndroid
      ? "http://10.0.2.2:8080/api/recipe"
      : "http://localhost:8080/api/recipe";

  HomeController() {
    getAllRecipes();
  }

  Future<void> getAllRecipes() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = jsonDecode(response.body);
        List<RecipeDTO> recipes = recipeJsonList.map((json) =>
            RecipeDTO.fromJson(json)).toList();
        listOfRecipes.assignAll(recipes);
      } else {
        throw Exception("Error loading the recipes");
      }
    } catch(e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<RecipeDTO>> getRecipesByTitle(String search) async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/title/$search")
      );
      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = jsonDecode(response.body);
        List<RecipeDTO> recipes = recipeJsonList.map((json) =>
            RecipeDTO.fromJson(json)).toList();

        if ((recipes).isEmpty) {
          return getRecipesByIngredient(search);
        } else{
          listOfRecipes.assignAll(recipes);
          return listOfRecipes;
        }
      } else {
        throw Exception("Failed to fetch recipes. Status code: "
            "${response.statusCode}.");
      }
    } catch(e) {
        throw Exception("Error occurred: $e");
      }
  }

  Future<List<RecipeDTO>> getRecipesByIngredient(String search) async {
    try {
      final response = await http.get(
          Uri.parse("$apiUrl/ingredient/$search")
      );
      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = jsonDecode(response.body);
        List<RecipeDTO> recipes = recipeJsonList.map((json) =>
            RecipeDTO.fromJson(json)).toList();
        listOfRecipes.assignAll(recipes);
        return listOfRecipes;
      } else {
        throw Exception("Failed to fetch recipes. Status code: "
            "${response.statusCode}.");
      }
    } catch(e) {
      throw Exception("Error occurred: $e");
    }
  }
}