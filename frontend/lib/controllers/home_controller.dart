import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../DTOs/recipe_dto.dart';

class HomeController extends GetxController {
  List<RecipeDTO> listOfRecipes = [];

  Future<List<RecipeDTO>> getAllRecipes() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:8080/api/recipe"),
      );

      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = jsonDecode(response.body);
        List<RecipeDTO> recipes = recipeJsonList.map((json) => RecipeDTO.fromJson(json)).toList();
        listOfRecipes = recipes;
        return listOfRecipes;
      } else {
        print("Login Error: ${response.statusCode}");
        return [];
      }

    } catch(e) {
      print("Exception: $e");
      }
    return [];
  }
}