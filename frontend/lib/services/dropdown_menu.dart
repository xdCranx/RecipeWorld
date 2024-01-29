import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tuple/tuple.dart';
import '../controllers/add_recipe_controller.dart';

class PopupMenu extends StatelessWidget {
  final AddRecipeController addRecipeController =
      Get.put(AddRecipeController());
  PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          width: 370,
          height: 400,
          context: context,
          bodyBuilder: (context) => Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.purple.shade900, width: 5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: addRecipeController.listOfIngredients
                      .map((ingredient) => SizedBox(
                            width: 350,
                            child: ElevatedButton(
                              onPressed: () {
                                addRecipeController
                                    .updateIngredientLists(ingredient);
                                addRecipeController.listOfIngredientAndQuantities.add(Tuple2(ingredient.id, 0));
                              },
                              child: Text(ingredient.name),
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          }),
        );
      },
      child: Material(
        elevation: 8,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade900, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            "Choose ingredients",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
