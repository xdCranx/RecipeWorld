import 'package:flutter/material.dart';
import 'recipe.dart';
import 'ingredient.dart';
class IngredientList extends StatelessWidget {
  final Ingredient ingredient;
  IngredientList({ required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(ingredient.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                )),

          ],
        ),
      ),
    );
  }
}

class IngredientButtons extends StatelessWidget {
  final Ingredient ingredient;
  IngredientButtons({ required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(width: 0.01,color: Colors.transparent),
              shape: RoundedRectangleBorder()),
          onPressed: (){},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(ingredient.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}