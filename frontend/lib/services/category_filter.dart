import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';


enum Categories { drink, breakfast, lunch, diner }
HomeController homeController1 = Get.put(HomeController());
//homeController1.getAllCategories();
List<CategoryDTO> listOfCategories2 = homeController1.listOfCategories.toList();




class FilterCategoriesChip extends StatefulWidget {

  const FilterCategoriesChip({super.key});

  @override
  State<FilterCategoriesChip> createState() => _FilterCategoriesChipState();
}
//List<CategoryDTO> Cat= homeController.listOfCategories.toList();
class _FilterCategoriesChipState extends State<FilterCategoriesChip> {
  final HomeController homeController = Get.put(HomeController());
  Set<CategoryDTO> filters = <CategoryDTO>{};

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /*Wrap(
            spacing: 5.0,
            children: Categories.values.map((Categories exercise) {
              return FilterChip(
                label: Text(exercise.name),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(exercise);
                    } else {
                      filters.remove(exercise);
                    }
                  });
                },
              );
            }).toList(),
          ),*/
          Expanded(
            child: Obx(() {
              homeController.getAllCategories();
              final List<CategoryDTO> listOfCategories = homeController.listOfCategories.toList();
              if (listOfCategories.isEmpty) {

                return const Center(child: CircularProgressIndicator());
              } else {
                return Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.spaceAround,
                  children: listOfCategories2.map((category) => FilterChip(
                    label: Text(category.name),
                    selected: filters.contains(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          filters.add(category);
                        } else {
                          filters.remove(category);
                        }
                      });
                    },

                  )).toList(),
                );
              }
            }
    ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map(( CategoryDTO e) => e.name).join(', ')}',

          ),
        ],
      ),
    );
  }
}





class FilterButton extends StatefulWidget {

  FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(context: context, bodyBuilder: (context)=> Container(
          height: 150,
          child: FilterCategoriesChip(),

        ));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey,
                width: 1.5
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[200],
          ),
          child: Text("Filter",
            style: TextStyle(
                fontSize: 20, color: Colors.deepPurple,
                fontWeight: FontWeight.bold
            ),)
      ),

    );
  }
}

