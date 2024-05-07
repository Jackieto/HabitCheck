import 'package:flutter/material.dart';

class NewHabitBox extends StatelessWidget {

  final habitController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const NewHabitBox({super.key, required this.habitController, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: habitController,
      ),


      actions: [
        //Botón de guardar
        MaterialButton(
          onPressed: onSave, 
          color: Color.fromARGB(255, 29, 185, 128),
          child: Text(
            "Guardar",
            style: TextStyle(color: Colors.white),
            ), 
          ),


          //Botón de cancelar
          MaterialButton(
          onPressed: onCancel,
          color: Colors.red,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white),
             ),
          ),
      ],

    );
  }
}