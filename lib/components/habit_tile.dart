import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

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

             // Botón de opciones
           
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'opcion_1',
                    child: Text('Opción 1'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'opcion_2',
                    child: Text('Opción 2'),
                  ),
                  // Agrega más opciones si lo deseas
                ],
                onSelected: (String value) {
                  // Maneja la selección de la opción aquí
                },
              ),
              
            ],
          ),
        ),
    );
  }
}