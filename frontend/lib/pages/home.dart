import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:recipe_world2/services/recipe_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// List<RecipeDTO> Recipes =[];

List<String> categories = ["Breakfast", "Dinner", "Lunch", "Drink"];
String? _chosenCategory;

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/userpage');
            },
            icon: const Icon(Icons.person, size: 40),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_recipe');
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: IMPLEMENT FILTERING
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
                child: Text('Filter'),
              ),
              const SizedBox(
                width: 150,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder<List<RecipeDTO>>(
            future: homeController.getAllRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                List<RecipeDTO> recipes = snapshot.data!;
                return Column(
                  children: recipes.map(
                        (recipe) => RecipeList(
                      recipe: recipe,
                      delete: () {
                        setState(() {
                          recipes.remove(recipe);
                        });
                      },
                    ),
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

