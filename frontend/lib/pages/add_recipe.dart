import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';
import 'package:recipe_world2/controllers/add_recipe_controller.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final AddRecipeController addRecipeController =
      Get.put(AddRecipeController());

  CategoryDTO? _chosenCategory;
  List<Ingredient> availableIngredients = [
    Ingredient(id: 1, name: 'mięso', unit: 'sztuki'),
    Ingredient(id: 2, name: 'bułka tarta', unit: 'gramy'),
    Ingredient(id: 3, name: 'jajko', unit: 'sztuki'),
  ];
  List<Ingredient> addedIngredients = [];

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
        child: Column(
          children: [
            Center(
              child: Text('Add new Recipe',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              // height: 100,
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
                  value: _chosenCategory,
                  dropdownColor: Colors.transparent,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(30.0),
                  items: addRecipeController.listOfCategories
                      .map<DropdownMenuItem<CategoryDTO>>(
                          (CategoryDTO category) {
                    return DropdownMenuItem<CategoryDTO>(
                        value: category,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Container(
                            // height: 100.0,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade200,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    color: Colors.purple.shade900, width: 5)),
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
                      _chosenCategory = newValue;
                    });
                  },
                  hint: Text(
                    "Choose category",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  icon: null,
                  isExpanded: true,
                  isDense: false,
                  alignment: Alignment.center,
                );
              }),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Recipe name',
                hintText: 'Enter recipe name',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Recipe description',
                hintText: 'Enter recipe description',
              ),
            ),
            const SizedBox(height: 40),
            PopupMenuButton(
              itemBuilder: (context) {
                return availableIngredients
                    .map((ingredient) => PopupMenuItem(
                          value: ingredient,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                availableIngredients.remove(ingredient);
                                addedIngredients.add(ingredient);
                              });
                            },
                            child: Text(ingredient.name),
                          ),
                        ))
                    .toList();
              },
            ),
            Column(
              children: addedIngredients
                  .map((ingredient) => ElevatedButton(
                        onPressed: () {
                          // Handle button press for the added ingredient
                        },
                        child: Text(ingredient.name),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Get.close(1);
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
          ],
        ),
      ),
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String unit;

  Ingredient({required this.id, required this.name, required this.unit});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddRecipePage(),
    );
  }
}
