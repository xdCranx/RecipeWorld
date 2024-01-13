import 'package:flutter/material.dart';
import 'package:popover/popover.dart';




class PopupMenu extends StatelessWidget {
List<ElevatedButton>children;
   PopupMenu({super.key, required this.children});


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        showPopover(context: context, bodyBuilder: (context)=> Container(
          height: (children.length.toDouble())*50,
          child: Column(
            children:
              children.map((child) => Container(width: double.infinity,

                child: child,)
          ).toList()),
        ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: 1.5
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text("Choose ingredients",
        style: TextStyle(
          fontSize: 20, color: Colors.grey[600],
          fontWeight: FontWeight.bold
        ),)
      ),

    );
  }
}




