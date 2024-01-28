import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_ingredient_dto.dart';
import 'package:recipe_world2/DTOs/review_dto.dart';
import '../DTOs/recipe_dto.dart';
import '../services/recipe_page_service.dart';

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
  final TextEditingController reviewTextController = TextEditingController();
  bool enteredEmptyText = false;

  @override
  void initState() {
    super.initState();
    fetchReviewsDetails();
    fetchRecipeDetails();
    setState(() {});
  }

  Future<void> fetchReviewsDetails() async {
    Map<String, dynamic> result = await RecipePageService.fetchReviewsDetails(widget.recipeId);

    if (result.containsKey('reviews')) {
      List<ReviewDTO> reviewDTO = result['reviews'];
      reviews = reviewDTO;
    } else if (result.containsKey('reviewError')) {
      print(result['reviewError']);
    }
  }

  Future<void> fetchRecipeDetails() async {
    Map<String, dynamic> result = await RecipePageService.fetchRecipeDetails(widget.recipeId);

    if (result.containsKey('recipe')) {
      RecipeDTO recipeDTO = result['recipe'];
      recipe = recipeDTO;

      List<RecipeIngredientDTO> ingredients = result['ingredients'];
      this.ingredients = ingredients;

      setState(() {});
    } else if (result.containsKey('recipeError')) {
      print(result['recipeError']);
    }
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
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.grey[400],
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
                  color: Colors.grey[800],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                recipe!.description,
                style: TextStyle(
                  color: Colors.grey[700],
                  letterSpacing: 2,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Ingredients:",
                style: TextStyle(
                  color: Colors.grey[800],
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
              const SizedBox(height: 40,),
              Text(
                "Reviews:",
                style: TextStyle(
                  color: Colors.grey[800],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: reviewTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter your review',
                        errorText: enteredEmptyText ? 'Review cannot be empty' : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (reviewTextController.text.isNotEmpty) {
                        int recipeId = widget.recipeId;
                        Map<String, dynamic> result = await RecipePageService.addReview(recipeId, reviewTextController.text);

                        if (result.containsKey('success')) {
                          await fetchReviewsDetails();
                        } else {
                          print(result['error']);
                        }
                      } else {
                        setState(() {
                          enteredEmptyText = true;
                        });

                        Timer(const Duration(seconds: 2), () {
                          setState(() {
                            enteredEmptyText = false;
                          });
                        });
                      }

                      reviewTextController.clear();
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[900]
                      ),
                    ),
                  ),
                ],
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
                    color: Colors.grey[700],
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ingredient.quantity.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      )
                    ),
                    const SizedBox(width: 10,),
                    Text(
                      ingredient.unit,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
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
      color: Colors.purple[800],
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
                    color: Colors.grey[400],
                  )
                ),
                Text(
                  "💭: ${review.comment}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[200],
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