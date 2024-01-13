import 'package:flutter/material.dart';
import 'package:recipe_world2/services/recipe_list.dart';
import '/services/recipe.dart';
import '/services/recipe_list.dart';

class FavouritesPage extends StatefulWidget {
    const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();


}

List<Recipe> favRecipes =[
  Recipe(id: 1, title: 'schabowy', description: 'zrob schabowego', category_id: 3, author_id: 1, date: DateTime.now(), preptime: 8),
  Recipe(id:2, title: "mielony ", description: 'zrob schabowego', category_id: 3, author_id: 1, date: DateTime.now(), preptime: 3)
];

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
          removeAllowed: true,
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

