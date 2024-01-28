import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/pages/recipe_page.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key});

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My recipes"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.grey[400],
      ),
      body: FutureBuilder<List<RecipeDTO>>(
        future: userController.getMyRecipes(),
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
                  MyRecipesPageRecipeList(
                    recipe: recipe,
                    delete: () async {
                      await userController.deleteMyRecipe(recipe.id);
                      await userController.getMyRecipes();
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

class MyRecipesPageRecipeList extends StatelessWidget {
  final RecipeDTO recipe;
  final VoidCallback delete;
  const MyRecipesPageRecipeList({super.key,  required this.recipe, required this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => RecipePage(recipeId: recipe.id,)));
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 0.01,color: Colors.transparent),
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
                        fontSize: 20,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      recipe.category.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 10),
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