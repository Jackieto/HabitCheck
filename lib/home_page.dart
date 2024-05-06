import 'package:flutter/material.dart';
import 'package:habitcheck/components/habit_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  List habitList = [
    ["Estudiar",false],
    ["Meditar", false],
  ];


  //funcion para comprobar que se ha realizado un habito
  void checkBoxTapped(bool? value, int index){
    setState(() {
      habitList[index][1]= value!; // ! para controlar que el valor no es null
    }); 
  }

  //crear un nuevo habito
  void createNewHabit(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 174, 204),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context,index){
          return HabitTile(
          habitName: habitList[index][0],  //primer atributo de cada elemento de la lista
           habitCompleted:habitList[index][1],
           onChanged: (value) => checkBoxTapped(value,index),
           );
        }
        
        
        )
    );
  }
}