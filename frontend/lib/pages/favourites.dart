import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/services/recipe_list.dart';
import '/services/recipe.dart';
import '/services/recipe_list.dart';

class FavouritesPage extends StatefulWidget {
    const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();


}

List<RecipeDTO> favRecipes =[];

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Favourite recipes"),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body:
      Column(
        children:
        favRecipes.map((recipe) => RecipeList(
            recipe: recipe,
            delete: () {
              setState(() {
                favRecipes.remove(recipe);
              });
            }

        )).toList(),

      ),
    );
  }
}

