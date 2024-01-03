import 'package:flutter/material.dart';
import 'recipe.dart';
import '/pages/recipe_page.dart';
class RecipeList extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback delete;
  RecipeList({ required this.recipe, required this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => RecipePage()));
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.01,color: Colors.transparent),
          shape: RoundedRectangleBorder()

        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(recipe.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  )),
              SizedBox(height: 6),
              Text(recipe.description,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800]
                  )),
              SizedBox(height:8),
              TextButton.icon(
                  onPressed: delete,
                  icon: Icon(Icons.delete),
                  label: Text('remove recipe'))

            ],
          ),
        ),
      ),
    );
  }
}

