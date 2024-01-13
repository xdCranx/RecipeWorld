import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

enum Categories { drink, breakfast, lunch, diner }


class FilterCategoriesChip extends StatefulWidget {
  const FilterCategoriesChip({super.key});

  @override
  State<FilterCategoriesChip> createState() => _FilterCategoriesChipState();
}

class _FilterCategoriesChipState extends State<FilterCategoriesChip> {
  Set<Categories> filters = <Categories>{};

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Wrap(
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
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map((Categories e) => e.name).join(', ')}',

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

