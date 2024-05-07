import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsClicked;
  final Function(BuildContext)? deleteClicked;


  const HabitTile({
    super.key, 
    required this.habitName, 
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsClicked,
    required this.deleteClicked
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
                    value: 'Editar',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                    ),
                  ),
                
                  PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'Delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Eliminar'),
                    ),
                    
                  ),

                  // Agrega más opciones si lo deseas
                ],
                onSelected: (String value) {
                  if(value == 'Editar'){
                      settingsClicked;
                  }

                  if(value == 'Delete'){
                      deleteClicked!(context);
                  }
                },
              ),
              
            ],
          ),
        ),
    );
  }
}