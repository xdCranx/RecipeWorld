import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_ingredient_dto.dart';
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
  late List<RecipeIngredientDTO> ingredients = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    String apiUrl = "";
    if (Platform.isAndroid) {
      apiUrl = "http://10.0.2.2:8080/api/recipe";
    } else {
      apiUrl = "http://localhost:8080/api/recipe";
    }

    try {
      final response = await http.get(
        Uri.parse("$apiUrl/${widget.recipeId}"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> recipeJson = json.decode(response.body);
        RecipeDTO recipeDTO = RecipeDTO.fromJson(recipeJson);

        recipe = recipeDTO;
      } else {
        print("Get Recipe Error: ${response.statusCode}");
        return;
      }
    } catch (e) {
      print("Exception: $e");
      return;
    }

    ingredients = recipe!.recipeIngredients.map((ingredient) {
      return RecipeIngredientDTO(id: ingredient.id, name: ingredient.name, unit: ingredient.unit, quantity: ingredient.quantity);
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
      body: SingleChildScrollView( // Wrap your content with SingleChildScrollView
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
                children: ingredients
                    .map(
                      (ingredient) => IngredientList(
                    ingredient: ingredient,
                  ),
                )
                    .toList(),
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