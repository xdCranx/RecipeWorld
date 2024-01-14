import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/pages/recipe_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My favorites"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<RecipeDTO>>(
        future: userController.getMyFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            List<RecipeDTO> myRecipes = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: myRecipes.map((recipe) =>
                  FavoritesPageRecipeList(
                    recipe: recipe,
                    delete: () async {
                      await userController.removeFromMyFavorites(recipe.id);
                      await userController.getMyFavorites();
                      setState(() {});
                    },
                  ),
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class FavoritesPageRecipeList extends StatelessWidget {
  final RecipeDTO recipe;
  final VoidCallback delete;
  const FavoritesPageRecipeList({super.key,  required this.recipe, required this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: (){
          Get.to(RecipePage(recipeId: recipe.id));
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.01, color: Colors.transparent),
          shape: const RoundedRectangleBorder()
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      recipe.author.username,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "🕒: ${recipe.prepTime}min",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 30,
                onPressed: delete,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}