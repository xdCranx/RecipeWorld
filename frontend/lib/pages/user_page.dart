import 'package:flutter/material.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/pages/favourites.dart';
import 'package:recipe_world2/pages/my_reviews_page.dart';
import '/services/user.dart';
import 'my_recipes.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User loggedUser = Get.find<UserController>().user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User profile",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child:
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20,),
              Text(
                loggedUser.username,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 55,
                    fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 70,),
              OutlinedButton.icon(
                icon: const Icon(Icons.add_circle_outline),
                label: const Text(
                  "ADD RECIPE",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[800]),
                  fixedSize: MaterialStateProperty.all(const Size(220, 70)),
                  side: MaterialStateProperty.all(BorderSide(width: 3, color: Colors.purple.shade800)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text(
                  "MY RECIPES",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[800]),
                  fixedSize: MaterialStateProperty.all(const Size(220, 70)),
                  side: MaterialStateProperty.all(BorderSide(width: 3, color: Colors.purple.shade800)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const MyRecipesPage()));
                },
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                icon: const Icon(Icons.favorite),
                label: const Text(
                  "FAVORITES",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[800]),
                  fixedSize: MaterialStateProperty.all(const Size(220, 70)),
                  side: MaterialStateProperty.all(BorderSide(width: 3, color: Colors.purple.shade800)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(FavoritesPage());
                },
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                icon: const Icon(Icons.dashboard_rounded),
                label: const Text(
                  "MY REVIEWS",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[800]),
                  fixedSize: MaterialStateProperty.all(const Size(220, 70)),
                  side: MaterialStateProperty.all(BorderSide(width: 3, color: Colors.purple.shade800)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyReviewsPage()));
                },
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  "DELETE ACCOUNT",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[800]),
                  fixedSize: MaterialStateProperty.all(const Size(220, 70)),
                  side: MaterialStateProperty.all(const BorderSide(width: 3, color: Colors.red)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  bool confirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Deletion"),
                        content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // User confirmed the deletion
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed == true) {
                    await Get.find<UserController>().deleteMyAccount();
                  }
                },
              ),
            ]
          ),
        )
      )
    );
  }
}