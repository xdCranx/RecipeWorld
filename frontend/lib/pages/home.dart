import 'package:flutter/material.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/services/recipe_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<RecipeDTO> Recipes =[];

List<String> categories = [
  "Breakfast",
  "Dinner",
  "Lunch",
  "Drink"
];
String? _chosenCategory;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/user');
          }, icon: Icon(Icons.person, size:40))
        ],

      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, '/add_recipe');
        },
        backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      body:
      Column(
        children: [
          SizedBox(
              height: 20
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              ElevatedButton(onPressed: (){//TODO: IMPLEMENT FILTERING
                 },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Text('Filter')),

              SizedBox(
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
          Container(
            child: Column(
              children:
              Recipes.map((recipe) => RecipeList(
                  recipe: recipe,
                  delete: () {
                    setState(() {
                      Recipes.remove(recipe);
                    });
                  }

              )).toList(),

            ),
          ),
        ],
      ),
    );
  }
}