import 'package:flutter/material.dart';
import 'package:recipe_world2/pages/home.dart';
/*import 'pages/add_recipe.dart';
import 'pages/favourites.dart';*/
import 'services/user.dart';
import 'pages/user_page.dart';
import 'pages/login.dart';
import 'pages/my_recipes.dart';
import 'pages/recipe_page.dart';
import 'pages/add_recipe.dart';
import 'pages/test_page.dart';

void main() {

  runApp( MaterialApp(
      initialRoute: '/',
      routes:{
        '/':(context) => Login(),
        '/home':(context) => HomePage(),
        '/user': (context) => UserPage(),
        '/myrecipes': (context) => MyRecipesPage(),
        '/recipe': (context) => RecipePage(),
        '/add_recipe': (context) => AddRecipePage(),
        '/test_page': (context) => TestPage(),
      }
  ));
}