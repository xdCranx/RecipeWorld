import 'package:flutter/material.dart';
import 'package:recipe_world2/services/recipe_list.dart';
import '/services/recipe.dart';
import '/services/recipe_list.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key});

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

List<Recipe> myRecipes =[
  Recipe(id: 1, title: 'schabowy', description: 'zrob schabowego', category_id: 3, author_id: 1, date: DateTime.now(), preptime: 7)
];

class _MyRecipesPageState extends State<MyRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("My recipes"),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body:
      SingleChildScrollView(
        child: Column(
          children:
          myRecipes.map((recipe) => RecipeList(
              recipe: recipe,
              delete: () {
                setState(() {
                  myRecipes.remove(recipe);
                });
              }
        
          )).toList(),
        
        ),
      ),
    );
  }
}
