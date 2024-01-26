import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:recipe_world2/pages/home.dart';
import 'package:recipe_world2/pages/register.dart';
import 'pages/user_page.dart';
import 'pages/login.dart';
import 'pages/add_recipe.dart';

void main() {
  runApp(RecipeWorld());
}

class RecipeWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Data Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const Login() ),
        GetPage(name: '/register', page: () => const Register() ),
        GetPage(name: '/home', page: () => const HomePage() ),
        GetPage(name: '/userpage', page: () => const UserPage() ),
        GetPage(name: '/userpage', page: () => const UserPage() ),
        GetPage(name: '/addrecipe', page: () => const AddRecipePage() ),
      ],
    );
  }

}