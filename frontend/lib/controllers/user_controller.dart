import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/services/user.dart';

class UserController extends GetxController {

  late User _user;
  get userId=>_user.id;
  get userUsername=>_user.username;
  get user=> _user;

  late List<RecipeDTO> _myRecipes;
  get myRecipes=> _myRecipes;

  final String apiUrl = "http://localhost:8080/api/user";
  final String myRecipesUrl = "http://localhost:8080/api/recipe/author";

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: '{"username": "$username", "password": "$password"}',
      );

      if (response.statusCode == 200) {
        _user = User(
            id: response.body.toString(),
            username: username,
            password: password
        );
        return true;
      } else {
        print("Login Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

  Future<List<RecipeDTO>> getMyRecipes() async {
    try {
      final response = await http.get(
        Uri.parse("$myRecipesUrl/${_user.id}"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = json.decode(response.body);
        List<RecipeDTO> recipes = recipeJsonList.map((json) => RecipeDTO.fromJson(json)).toList();
        print(recipes);
        _myRecipes = recipes;

        return recipes;
      } else {
        print("Get My Recipes Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }
}
