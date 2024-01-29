import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_world2/controllers/add_recipe_controller.dart';

import '../DTOs/ingredient.dart';

class IngredientButtons extends StatelessWidget {
  final Ingredient ingredient;
  final AddRecipeController addRecipeController = Get.put(AddRecipeController());
  IngredientButtons({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 16, 16, 4),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 0.01,color: Colors.transparent),
              shape: const RoundedRectangleBorder()),
          onPressed: (){
            addRecipeController.listOfAddedIngredients.remove(ingredient);
            addRecipeController.listOfIngredients.add(ingredient);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ingredient.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox( width:60, height:30,

                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Text(ingredient.unit,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      )
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}