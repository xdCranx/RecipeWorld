import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/services/user.dart';
import '../DTOs/review_dto.dart';

class UserController extends GetxController {

  late User _user;
  get userId=>_user.id;
  get userUsername=>_user.username;
  get user=> _user;

  late List<RecipeDTO> _myRecipes;
  get myRecipes=> _myRecipes;

  late List<ReviewDTO> _myReviews;
  get myReviews=> _myReviews;

  late String apiUrl;
  late String myRecipesUrl;
  late String myReviewsUrl;
  late String deleteReviewApiUrl;

  Future<bool> login(String username, String password) async {
    if(Platform.isAndroid) {
      apiUrl = "http://10.0.2.2:8080/api/user";
    } else {
      apiUrl = "http://localhost:8080/api/user";
    }

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
    if(Platform.isAndroid) {
      myRecipesUrl = "http://10.0.2.2:8080/api/recipe/author";
    } else {
      myRecipesUrl = "http://localhost:8080/api/recipe/author";
    }

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

  Future<List<ReviewDTO>> getMyReviews() async {
    if(Platform.isAndroid) {
      myReviewsUrl = "http://10.0.2.2:8080/api/review/user";
    } else {
      myReviewsUrl = "http://localhost:8080/api/review/user";
    }

    try {
      final response = await http.get(
        Uri.parse("$myReviewsUrl/${_user.id}"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = json.decode(response.body);
        List<ReviewDTO> reviews = recipeJsonList.map((json) => ReviewDTO.fromJson(json)).toList();
        print(reviews);
        _myReviews = reviews;

        return reviews;
      } else {
        print("Get My Recipes Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteMyReview(int reviewId) async {
    if (Platform.isAndroid) {
      deleteReviewApiUrl = "http://10.0.2.2:8080/api/review";
    } else {
      deleteReviewApiUrl = "http://localhost:8080/api/review";
    }

    try {
      final response = await http.delete(
        Uri.parse("$deleteReviewApiUrl/$reviewId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'error': "Delete Review Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }
}