import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';
import 'package:recipe_world2/controllers/add_recipe_controller.dart';
import 'package:recipe_world2/controllers/user_controller.dart';

import '../services/dropdown_menu.dart';
import '../services/ingredient_list.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final AddRecipeController addRecipeController =
      Get.put(AddRecipeController());
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController recipeDescriptionController =
      TextEditingController();
  final TextEditingController recipePrepTimeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add recipe",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.grey[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50.0),
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  controller: recipeNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 4,
                      ), // Border color when the TextField is not focused
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.purple[800]!,
                          width:
                              4), // Border color when the TextField is focused
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 17),
                    labelText: 'Recipe name',
                    labelStyle:
                        TextStyle(fontSize: 20, color: Colors.grey[500]),
                    floatingLabelStyle:
                        TextStyle(fontSize: 20, color: Colors.purple[800]),
                    hintText: 'Enter recipe name',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey[400]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 230,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 5,
                        ),
                      ),
                      child: Obx(() {
                        return DropdownButton<CategoryDTO>(
                          value: addRecipeController.chosenCategory,
                          dropdownColor: Colors.purple.withAlpha(150),
                          elevation: 9,
                          underline: Container(
                            height: 0,
                            color: Colors.purple.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          items: addRecipeController.listOfCategories
                              .map<DropdownMenuItem<CategoryDTO>>(
                                  (CategoryDTO category) {
                            return DropdownMenuItem<CategoryDTO>(
                                value: category,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.purple.shade200,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.purple.shade900,
                                            width: 3)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      category.name.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ));
                          }).toList(),
                          onChanged: (CategoryDTO? newValue) {
                            setState(() {
                              addRecipeController.chosenCategory = newValue;
                            });
                          },
                          hint: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.purple.shade900, width: 2.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Choose category",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          icon: const SizedBox.shrink(),
                          isExpanded: true,
                          alignment: Alignment.center,
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: recipePrepTimeController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple[900]!,
                                width: 2.5,
                              ), // Border color when the TextField is not focused
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.purple[900]!,
                                  width:
                                      2.5), // Border color when the TextField is focused
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 5,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 17),
                            labelText: 'Prep time [m]',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                fontSize: 20, color: Colors.purple[800]),
                            // hintText: 'Enter recipe prep time',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Colors.grey[400]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PopupMenu(),
              const SizedBox(height: 10),
              Material(
                elevation: 5, // Set the elevation for the shadow effect
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 370,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade900,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: Column(
                        children: addRecipeController.listOfAddedIngredients
                            .map((ingredient) => IngredientButtons(
                                  ingredient: ingredient,
                                ))
                            .toList(),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20.0),
                child: TextField(
                  minLines: 5,
                  maxLines: 15,
                  style: const TextStyle(fontSize: 15),
                  controller: recipeDescriptionController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 2,
                      ), // Border color when the TextField is not focused
                      borderRadius: BorderRadius.circular(20.0),
                      gapPadding: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.purple[800]!,
                          width:
                              2), // Border color when the TextField is focused
                      borderRadius: BorderRadius.circular(20.0),
                      gapPadding: 5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 17),
                    labelText: 'Recipe description',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                    ),
                    floatingLabelStyle:
                        TextStyle(fontSize: 20, color: Colors.purple[800]),
                    hintText: 'Describe the steps of the recipe',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(25.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (addRecipeController.listOfIngredientAndQuantities
                        .any((tuple) => tuple.item2 == 0)) {
                      Get.snackbar(
                        "Invalid action",
                        "Ingredients cannot have empty quantity field",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.grey[200],
                        backgroundColor: Colors.grey[400],
                        backgroundGradient: LinearGradient(
                          colors: [
                            Colors.purple.withOpacity(0.7),
                            Colors.purple.shade900
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      );
                    } else {
                      try {
                        addRecipeController.addRecipe(
                            userId: Get.find<UserController>().user.id,
                            categoryId: addRecipeController.chosenCategory!.id,
                            title: recipeNameController.text,
                            description: recipeDescriptionController.text,
                            ingredients: addRecipeController
                                .listOfIngredientAndQuantities,
                            prepTime: int.parse(recipePrepTimeController.text));
                      } catch (e) {
                        Get.snackbar(
                          "Invalid action",
                          "All fields must be filled",
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.grey[200],
                          backgroundColor: Colors.grey[400],
                          backgroundGradient: LinearGradient(
                            colors: [
                              Colors.purple.withOpacity(0.7),
                              Colors.purple.shade900
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        );
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
