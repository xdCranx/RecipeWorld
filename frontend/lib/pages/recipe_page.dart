import 'package:flutter/material.dart';
import '/services/recipe.dart';
import '/services/ingredient.dart';
import '/services/ingredient_list.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}
List<Ingredient> ingredients = [
  Ingredient(id: 1, name: 'mięso', unit: 'sztuki'),
  Ingredient(id: 2, name: 'bułka tarta', unit: 'gramy'),
  Ingredient(id: 3, name: 'jajko', unit: 'sztuki')
];
String d = 'zrób schabowego Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
Recipe recipe = new Recipe(id: 1, title: "Schabowy", description: d, category_id: 1, author_id: 1, date: DateTime.now());

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      title: Text(recipe.title,),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.blue,
    ),

    body:  Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(recipe.title ,
                  style: TextStyle(
                      color: Colors.grey[600],
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  )),
              SizedBox(height: 5),
              Text(recipe.description,
                  style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  )),
              SizedBox(height: 30),
              Text("Składniki:",
              style: TextStyle(
                  color: Colors.grey[600],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),

              Column(
                children:
                ingredients.map((ingredient) => IngredientList(
                    ingredient: ingredient,
                )).toList(),

              ),

            ]
        )
    )
    );
  }
}

