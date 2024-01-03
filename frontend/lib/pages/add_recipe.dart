import 'package:flutter/material.dart';
import '/services/ingredient.dart';
import '/services/ingredient_list.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}
List<Ingredient> availableIngredients = [
  Ingredient(id: 1, name: 'mięso', unit: 'sztuki'),
  Ingredient(id: 2, name: 'bułka tarta', unit: 'gramy'),
  Ingredient(id: 3, name: 'jajko', unit: 'sztuki')
];

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add recipe",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:Column(
        children: [
          Center(
            child: Text('Add new Recipe',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 28,
              fontWeight: FontWeight.bold
            )),
          ),

           TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Recipe name',
                hintText: 'Enter recipe name',
              ),
            ),
          SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Recipe description',
              hintText: 'Enter recipe description',
            ),
          ),
          SizedBox(height: 20),

          Text('Choose ingredients',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )),
          Column(
            children:
            availableIngredients.map((ingredient) => IngredientButtons(
              ingredient: ingredient,
            )).toList(),

          ),
          SizedBox(height: 25,),
          ElevatedButton(
              onPressed: (){},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("CONFIRM",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              )
          )

        ],)

      ),
    );
  }
}
