import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_ingredient_dto.dart';
import 'package:recipe_world2/DTOs/review_dto.dart';
import '../DTOs/recipe_dto.dart';
import 'package:http/http.dart' as http;

class RecipePage extends StatefulWidget {
  final int recipeId;

  const RecipePage({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late RecipeDTO? recipe;
  late List<RecipeIngredientDTO> ingredients = [];
  late List<ReviewDTO> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchRecipePageDetails();
  }

  Future<void> fetchRecipePageDetails() async {
    String recipeApiUrl = "";
    String reviewApiUrl = "";
    if (Platform.isAndroid) {
      recipeApiUrl = "http://10.0.2.2:8080/api/recipe";
      reviewApiUrl = "http://10.0.2.2:8080/api/review/recipe";
    } else {
      recipeApiUrl = "http://localhost:8080/api/recipe";
      reviewApiUrl = "http://localhost:8080/api/review/recipe";
    }

    try {
      final recipeResponse = await http.get(
        Uri.parse("$recipeApiUrl/${widget.recipeId}"),
        headers: {"Content-Type": "application/json"},
      );

      if (recipeResponse.statusCode == 200) {
        Map<String, dynamic> recipeJson = json.decode(recipeResponse.body);
        RecipeDTO recipeDTO = RecipeDTO.fromJson(recipeJson);

        recipe = recipeDTO;
      } else {
        print("Get Recipe Error: ${recipeResponse.statusCode}");
        return;
      }
    } catch (e) {
      print("Exception: $e");
      return;
    }

    try {
      final reviewResponse = await http.get(
        Uri.parse("$reviewApiUrl/${widget.recipeId}"),
        headers: {"Content-Type": "application/json"},
      );

      if (reviewResponse.statusCode == 200) {
        List<dynamic> reviewJsonList = json.decode(reviewResponse.body);
        List<ReviewDTO> reviewDTO = reviewJsonList.map((json) => ReviewDTO.fromJson(json)).toList();

        reviews = reviewDTO;
      } else {
        print("Get Review Error: ${reviewResponse.statusCode}");
        return;
      }
    } catch (e) {
      print("Exception: $e");
      return;
    }

    ingredients = recipe!.recipeIngredients.map((ingredient) {
      return RecipeIngredientDTO(
          id: ingredient.id,
          name: ingredient.name,
          unit: ingredient.unit,
          quantity: ingredient.quantity
      );
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe!.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                recipe!.title,
                style: TextStyle(
                  color: Colors.grey[600],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                recipe!.description,
                style: const TextStyle(
                  color: Colors.black54,
                  letterSpacing: 2,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Ingredients:",
                style: TextStyle(
                  color: Colors.grey[600],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: ingredients.map((ingredient) =>
                    IngredientList(
                    ingredient: ingredient,
                  ),
                ).toList(),
              ),
              const SizedBox(height: 30,),
              Text(
                "Reviews:",
                style: TextStyle(
                  color: Colors.grey[600],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviews.map((review) =>
                    ReviewList(
                      review: review,
                    ),
                ).toList(),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  final RecipeIngredientDTO ingredient;
  const IngredientList({super.key,  required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ingredient.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ingredient.quantity.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      )
                    ),
                    const SizedBox(width: 10,),
                    Text(
                      ingredient.unit,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      )
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final ReviewDTO review;
  const ReviewList({super.key,  required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.user.username,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[900],
                  )
                ),
                Text(
                  review.comment,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}