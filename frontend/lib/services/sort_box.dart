import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:recipe_world2/DTOs/recipe_dto.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  final HomeController homeController = Get.find<HomeController>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        showPopover(context: context, bodyBuilder: (context)=> Container(
          height: 200,
          width: 300,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            children: [
              OutlinedButton(onPressed: (){
                homeController.listOfRecipes.sort((a,b) => a.title.compareTo(b.title));

              }, child: Text("Sort Alphabetically")),
              OutlinedButton(onPressed: (){
                homeController.listOfRecipes.sort((a,b) => a.date.compareTo(b.date));

              }, child: Text("Sort by Date Added")),
              OutlinedButton(onPressed: (){
                homeController.listOfRecipes.sort((a,b) => a.category.name.compareTo(b.category.name));

              }, child: Text("Sort by Category")),
              SizedBox(
                width: 150,
                height: 50,
                child: TextField(
                  controller: searchController,
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {

                      await homeController.getRecipesByPrepTime(int.parse(value));
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

        ));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.deepPurple,
                width: 1.5
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: Text("Sort",
            style: TextStyle(
                fontSize: 20, color: Colors.deepPurple,
                fontWeight: FontWeight.bold
            ),)
      ),

    );
  }
}
