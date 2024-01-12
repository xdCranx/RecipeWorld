import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/services/recipe_list.dart';

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
        backgroundColor: Colors.blue,
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
                children: myRecipes
                    .map(
                      (recipe) => RecipeList(
                    recipe: recipe,
                    delete: () {
                      setState(() {
                        myRecipes.remove(recipe);
                      });
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
