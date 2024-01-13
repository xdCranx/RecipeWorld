import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import '/pages/recipe_page.dart';

class RecipeList extends StatelessWidget {
  final RecipeDTO recipe;
  final VoidCallback delete;
  const RecipeList({super.key,  required this.recipe, required this.delete });

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    )
                  ),
                  Text(
                    "${recipe.prepTime} minutes",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600]
                    )
                  ),
                ],
              ),
              const SizedBox(height:8),
              // Text(
              //   recipe.description,
              //   maxLines: 4,
              //   overflow: TextOverflow.fade,
              // ),
              TextButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: const Text('remove recipe')
              )
            ],
          ),
        ),
      ),
    );
  }
}

