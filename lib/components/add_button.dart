import 'package:flutter/material.dart';

class AddHabitButton extends StatelessWidget {
  
  final Function()? onPressed;
  
  const AddHabitButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
      
      );
  }
}