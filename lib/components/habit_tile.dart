import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;

  const HabitTile({
    super.key, 
    required this.habitName, 
    required this.habitCompleted,
    required this.onChanged
    
    });
    

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16), 
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(5) //circular borders
          ),
        child: Row(
          children: [
            //checkbox
            Checkbox(value: habitCompleted, onChanged:onChanged),

            //habitname
            Text(habitName),
          ],
        ),
      ),
    );
  }
}