import 'package:flutter/material.dart';
import 'package:recipe_world2/pages/favourites.dart';
import '/services/user.dart';
import 'my_recipes.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User loggedUser = new User(id:1,username:'Filip', email:'studentdebil@gmail.com', password: 'haslo123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("User profile",),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
        ),

        body:  Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('NAME',
                      style: TextStyle(

                          letterSpacing: 5.0
                      )),
                  SizedBox(height: 5),
                  Text(loggedUser.username,
                      style: TextStyle(
                          color: Colors.grey[600],
                          letterSpacing: 2,
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      )),
                  SizedBox(height: 30),

                  Row(
                    children: <Widget>[
                      Icon(Icons.alternate_email, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(loggedUser.email,
                        style: TextStyle(

                            fontSize: 18,
                            letterSpacing: 2
                        ),),

                    ],
                  ),
                  SizedBox(height: 30),
                  OutlinedButton.icon(
                    icon: Icon(Icons.favorite),
                    label:Text("View favourites"),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => FavouritesPage()));
                    },
                  ),

                  SizedBox(height: 30),
                  OutlinedButton.icon(
                    icon: Icon(Icons.person),
                    label:Text("My recipes"),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => MyRecipesPage()));
                    },
                  ),

                ]
            )
        )
    );
  }
}
