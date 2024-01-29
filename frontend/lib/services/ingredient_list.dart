import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/controllers/add_recipe_controller.dart';

import '../DTOs/ingredient.dart';

class IngredientButtons extends StatelessWidget {
  final Ingredient ingredient;
  final AddRecipeController addRecipeController =
      Get.put(AddRecipeController());
  IngredientButtons({super.key, required this.ingredient});
  final TextEditingController quantityController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 0.01, color: Colors.transparent),
              shape: const RoundedRectangleBorder()),
          onPressed: () {
            addRecipeController.listOfAddedIngredients.remove(ingredient);
            addRecipeController.listOfIngredients.add(ingredient);
            addRecipeController.listOfIngredientAndQuantities
                .removeWhere((tuple) => tuple.item1 == ingredient.id);
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 60,
                          height: 30,
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*$')),
                            ],
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            controller: quantityController,
                            onChanged: (value) {
                              addRecipeController.updateIngredientQuantities(
                                  ingredient.id, double.parse(value));
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Text(ingredient.unit,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          )),
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
