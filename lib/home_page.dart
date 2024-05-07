import 'package:flutter/material.dart';
import 'package:habitcheck/components/habit_tile.dart';
import 'package:habitcheck/components/add_button.dart';
import 'package:habitcheck/components/new_habit_box.dart';


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

  final _habitController = TextEditingController();

  void createNewHabit(){
      showDialog(context: context, builder: (context) { 
        return NewHabitBox(
          habitController: _habitController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit ,

        );
      },
    );
  }

  //guardar nuevo habito
  void saveNewHabit(){
    setState(() { 

    if(_habitController.text.trim().isEmpty){
    //   return error

    }else{
      habitList.add([_habitController.text,false]);
     }
      
    });

    _habitController.clear(); //limpiar texto
    Navigator.of(context).pop(); //ir al estado anterior

  }

  //cancelar nuevo habito
  void cancelNewHabit(){
    _habitController.clear(); //limpiar texto
    Navigator.of(context).pop(); //ir al estado anterior
  }

  void editHabit(int index){
    setState(() {
      habitList[index][0] = _habitController.text;
    });
      _habitController.clear(); //limpiar texto
      Navigator.of(context).pop(); //ir al estado anterior
  }

  //opciones de habito

  void openHabitSettings(int index){
    showDialog(
      context: context, 
      builder: (context){
        return NewHabitBox(
          habitController: _habitController,
          onSave: () => editHabit(index),
          onCancel: cancelNewHabit,
          );
      },
    );
  }


  //borrar habito

  void deleteHabit(int index){
      setState(() {
      habitList.remove(habitList[index]);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 174, 204),
      floatingActionButton: AddHabitButton(onPressed: createNewHabit),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context,index){
          return HabitTile(
          habitName: habitList[index][0],  //primer atributo de cada elemento de la lista
           habitCompleted:habitList[index][1],
           onChanged: (value) => checkBoxTapped(value,index),
           settingsClicked: (context) => openHabitSettings(index),
           deleteClicked: (context) => deleteHabit(index) ,

           );
        }
        
        
        )
    );
  }
}