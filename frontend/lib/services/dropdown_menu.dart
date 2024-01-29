import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class PopupMenu extends StatelessWidget {
  final List<ElevatedButton> children;

  PopupMenu({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          width: 370,
          height: 400,
          context: context,
          bodyBuilder: (context) => SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: children
                    .map((child) => SizedBox(
                  width: 350,
                  child: child,
                ))
                    .toList(),
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "Choose ingredients",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}