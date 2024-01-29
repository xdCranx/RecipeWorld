import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';



HomeController homeController1 = Get.put(HomeController());
List<CategoryDTO> listOfCategories2 = homeController1.listOfCategories.toList();




class FilterCategoriesChip extends StatefulWidget {

   FilterCategoriesChip({super.key});

  @override
  State<FilterCategoriesChip> createState() => _FilterCategoriesChipState();
}
//List<CategoryDTO> Cat= homeController.listOfCategories.toList();
class _FilterCategoriesChipState extends State<FilterCategoriesChip> {
  final HomeController homeController = Get.find<HomeController>();

  _FilterCategoriesChipState();
  Set<CategoryDTO> filters = <CategoryDTO>{};

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Expanded(
            child: Obx(() {

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
          //const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map(( CategoryDTO e) => e.name).join(', ')}\n',),

          ElevatedButton(onPressed: (){
            homeController.categoryFilters = RxList.from(filters);
            if(homeController.categoryFilters.isNotEmpty)
              homeController.getRecipesByCategory(homeController.categoryFilters[0]);
            else
              homeController.getAllRecipes();



          }, child: Text("Filter"))
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
  _FilterButtonState();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.getAllCategories();
        homeController1.categoryFilters.clear();
        showPopover(context: context, bodyBuilder: (context)=> Container(
          height: 180,
          width: 370,
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

