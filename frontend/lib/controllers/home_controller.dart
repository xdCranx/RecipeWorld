import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../DTOs/recipe_dto.dart';

class HomeController extends GetxController {
  List<RecipeDTO> listOfRecipes = [];
  late String apiUrl;

  Future<List<RecipeDTO>> getAllRecipes() async {
    if(Platform.isAndroid) {
      apiUrl = "http://10.0.2.2:8080/api/recipe";
    } else {
      apiUrl = "http://localhost:8080/api/recipe";
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
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