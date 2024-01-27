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

  late List<RecipeDTO> _myFavorites;
  get myFavorites=> _myFavorites;

  late String apiUrl;
  late String myRecipesUrl;
  late String myReviewsUrl;
  late String deleteReviewApiUrl;
  late String deleteAccountApiUrl;
  late String addToFavoritesApiUrl;
  late String userFavoritesApiUrl;
  late String removeFromFavoritesApiUrl;
  late String deleteMyRecipeApiUrl;

  void resetUser() {
    _user = User(id: '', username: '', password: '');
    _myRecipes = [];
    _myReviews = [];
    apiUrl = "";
    myReviewsUrl = "";
    myRecipesUrl = "";
    deleteAccountApiUrl = "";
    deleteReviewApiUrl = "";
    addToFavoritesApiUrl = "";
    userFavoritesApiUrl = "";
    removeFromFavoritesApiUrl = "";
    deleteMyRecipeApiUrl = "";
  }

  Future<void> toggleFavorite(int recipeId) async {
    if (isRecipeFavorite(recipeId)) {
      await removeFromMyFavorites(recipeId);
    } else {
      await addToMyFavorites(recipeId);
    }

    update();
  }

  bool isRecipeFavorite(int recipeId) {
    return myFavorites.any((favRecipe) => favRecipe.id == recipeId);
  }

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
        _myFavorites = await getMyFavorites();
        return true;
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Registration failed';
        Get.snackbar(
          "Login Error",
          errorMessage,
          snackPosition: SnackPosition.TOP,
        );
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

  Future<Map<String, dynamic>> deleteMyAccount() async {
    if (Platform.isAndroid) {
      deleteAccountApiUrl = "http://10.0.2.2:8080/api/user/delete?id=${_user.id}";
    } else {
      deleteAccountApiUrl = "http://localhost:8080/api/user/delete?id=${_user.id}";
    }

    try {
      final response = await http.delete(
        Uri.parse(deleteAccountApiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Get.find<UserController>().resetUser();
        Get.offAllNamed('/login');

        return {'success': true};
      } else {
        return {'error': "Delete Account Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }

  Future<Map<String, dynamic>> addToMyFavorites(int recipeId) async {
    if (Platform.isAndroid) {
      addToFavoritesApiUrl = "http://10.0.2.2:8080/api/user/${_user.id}/favorites/$recipeId/add";
    } else {
      addToFavoritesApiUrl = "http://localhost:8080/api/user/${_user.id}/favorites/$recipeId/add";
    }

    try {
      final response = await http.post(
        Uri.parse(addToFavoritesApiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        await getMyFavorites();
        update();

        return {'success': true};
      } else {
        return {'error': "Add to Favorites Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }

  Future<List<RecipeDTO>> getMyFavorites() async {
    if (Platform.isAndroid) {
      userFavoritesApiUrl = "http://10.0.2.2:8080/api/user/${_user.id}/favorites/getall";
    } else {
      userFavoritesApiUrl = "http://localhost:8080/api/user/${_user.id}/favorites/getall";
    }

    try {
      final response = await http.get(
        Uri.parse(userFavoritesApiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<dynamic> recipeJsonList = json.decode(response.body);
        List<RecipeDTO> userFavorites = recipeJsonList.map((json) => RecipeDTO.fromJson(json)).toList();
        _myFavorites = userFavorites;

        return userFavorites;
      } else {
        print("Get User Favorites Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> removeFromMyFavorites(int recipeId) async {
    if (Platform.isAndroid) {
      removeFromFavoritesApiUrl = "http://10.0.2.2:8080/api/user/${_user.id}/favorites/$recipeId/remove";
    } else {
      removeFromFavoritesApiUrl = "http://localhost:8080/api/user/${_user.id}/favorites/$recipeId/remove";
    }

    try {
      final response = await http.delete(
        Uri.parse(removeFromFavoritesApiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        await getMyFavorites();
        update();

        return {'success': true};
      } else {
        return {'error': "Remove from Favorites Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }

  Future<Map<String, dynamic>> deleteMyRecipe(int recipeId) async {
    if (Platform.isAndroid) {
      deleteMyRecipeApiUrl = "http://10.0.2.2:8080/api/recipe";
    } else {
      deleteMyRecipeApiUrl = "http://localhost:8080/api/recipe";
    }

    try {
      final response = await http.delete(
        Uri.parse("$deleteMyRecipeApiUrl/$recipeId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'error': "Delete recipe Error: ${response.statusCode}"};
      }
    } catch (e) {
      return {'error': "Exception: $e"};
    }
  }
}