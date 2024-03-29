import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/pages/recipe_page.dart';
import 'package:recipe_world2/services/category_filter.dart';
import 'package:recipe_world2/services/sort_box.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> categories = ["Breakfast", "Dinner", "Lunch", "Drink"];
//String? _chosenCategory;

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        leading: IconButton(
          icon: const Icon(
            Icons.logout_rounded,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.grey[400],
        actions: [
          IconButton(
            onPressed: () async {
              await Get.toNamed('/userpage');
              setState(() {});
            },
            icon: const Icon(Icons.person, size: 40,),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  FilterButton(),
                  SizedBox(width: 10),
                  SortButton(),
                ],
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: TextField(
                  controller: searchController,
                  onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        await homeController.getRecipesByTitle(value);
                      }
                      else {
                        await homeController.getAllRecipes();
                      }
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ),
                ),
              ),

            ],

          ),
          Expanded(
            child: Obx(() {

              final List<RecipeDTO> listOfRecipes = homeController.listOfRecipes.toList();
              if (listOfRecipes.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  children: listOfRecipes.map((recipe) => HomePageRecipeList(
                    recipe: recipe,
                  )).toList(),
                );
              }
            }),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class HomePageRecipeList extends StatefulWidget {
  final RecipeDTO recipe;

  const HomePageRecipeList({Key? key, required this.recipe}) : super(key: key);

  @override
  State<HomePageRecipeList> createState() => _HomePageRecipeListState();
}

class _HomePageRecipeListState extends State<HomePageRecipeList> {
  final UserController userController = Get.find<UserController>();

  void toggleFavorite() async {
    await userController.toggleFavorite(widget.recipe.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: (){
          Get.to(RecipePage(recipeId: widget.recipe.id));
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 0.01, color: Colors.transparent),
            shape: const RoundedRectangleBorder()
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.recipe.author.username,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "${widget.recipe.category.name.toUpperCase()} | "
                          "🕒: ${widget.recipe.prepTime}min",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 30,
                onPressed: toggleFavorite,
                icon: userController.isRecipeFavorite(widget.recipe.id)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ),
    );
  }
}