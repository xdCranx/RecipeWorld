import 'package:flutter/material.dart';
import 'recipe.dart';
import '/pages/recipe_page.dart';
class RecipeList extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback delete;
  final VoidCallback fav;
  final bool removeAllowed;
  final bool addToFavAllowed;
  RecipeList({ required this.recipe,   this.removeAllowed=false, this.addToFavAllowed=false, VoidCallback? delete, VoidCallback? fav }):
        delete = delete ?? (() {}),
        fav = fav ?? (() {});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => RecipePage()));
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.01,color: Colors.transparent),
          shape: RoundedRectangleBorder()

        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  Text(recipe.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      )),
                  Text("${recipe.preptime} minutes",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600]
                      )),
                ],
              ),
              SizedBox(height: 6),
              Text(recipe.description,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800]
                  )),

              SizedBox(height:8),
              if(removeAllowed == true)
              TextButton.icon(
                  onPressed: delete,
                  icon: Icon(Icons.delete),
                  label: Text('remove recipe')),

              if(addToFavAllowed == true)
                TextButton.icon(
                    onPressed: fav,
                    icon: Icon(Icons.favorite),
                    label: Text('Add to favourites'))

            ],
          ),
        ),
      ),
    );
  }
}

