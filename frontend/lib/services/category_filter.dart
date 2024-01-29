import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:recipe_world2/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/category_dto.dart';



HomeController homeController1 = Get.put(HomeController());
List<CategoryDTO> listOfCategories2 = homeController1.listOfCategories.toList();




class FilterCategoriesChip extends StatefulWidget {
  HomeController homeController;

   FilterCategoriesChip({super.key, required this.homeController});

  @override
  State<FilterCategoriesChip> createState() => _FilterCategoriesChipState(homeController: homeController);
}
//List<CategoryDTO> Cat= homeController.listOfCategories.toList();
class _FilterCategoriesChipState extends State<FilterCategoriesChip> {
  //final HomeController homeController = Get.put(HomeController());
  HomeController homeController;
  _FilterCategoriesChipState({required this.homeController});
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
              //homeController.categoryFilters.clear();
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
            setState(() {
              homeController.categoryFilters = RxList.from(filters);
              homeController.getRecipesByCategory(homeController.categoryFilters[0]);
            });


          }, child: Text("Filter"))
        ],
      ),
    );
  }
}





class FilterButton extends StatefulWidget {
  HomeController homeController;
  FilterButton({super.key, required this.homeController});

  @override
  State<FilterButton> createState() => _FilterButtonState(homeController: homeController);
}

class _FilterButtonState extends State<FilterButton> {
  HomeController homeController;
  _FilterButtonState({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.getAllCategories();
        homeController1.categoryFilters.clear();
        showPopover(context: context, bodyBuilder: (context)=> Container(
          height: 180,
          child: FilterCategoriesChip(homeController: homeController,),

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

