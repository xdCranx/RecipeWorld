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

List<String> categories = [
  "Breakfast",
  "Dinner",
  "Lunch",
  "Drink"
];


class _AddRecipePageState extends State<AddRecipePage> {
  String? _chosenCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add recipe",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
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

            SizedBox(height: 20,),

            Container(
              width: double.infinity,

              child: DropdownButton<String>(


                value: _chosenCategory,

                items: categories.map<DropdownMenuItem<String>>((String value) {

                  return DropdownMenuItem<String>(

                    value: value,

                    child: Text(value),

                  );

                }).toList(),

                onChanged: (String? newValue) {

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

              ),
            ),


            SizedBox(height: 20,),
        
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
            SizedBox(height: 20,
            ),
        
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
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
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
      ),
    );
  }
}
