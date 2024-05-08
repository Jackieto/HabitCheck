import 'package:flutter/material.dart';
import 'package:habitcheck/components/habit_tile.dart';
import 'package:habitcheck/components/add_button.dart';
import 'package:habitcheck/components/new_habit_box.dart';
import 'package:habitcheck/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  @override
  void initState(){

    //primera vez que se inicia
    if(_myBox.isEmpty){
      db.createDefaultData();
      db.updateDatabase();

    }
    //no es la primera vez que se inicia
    else{
      db.loadData();
     db.updateDatabase();

    }

    db.updateDatabase();

    super.initState();
  }

  //funcion para comprobar que se ha realizado un habito
  void checkBoxTapped(bool? value, int index){
    setState(() {
      db.habitList[index][1]= value!; // ! para controlar que el valor no es null
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
      db.habitList.add([_habitController.text,false]);
     }
      
    });

     db.updateDatabase();
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
      db.habitList[index][0] = _habitController.text;
    });

      db.updateDatabase();
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
      db.habitList.remove(db.habitList[index]);
      });
      db.updateDatabase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 174, 204),
      floatingActionButton: AddHabitButton(onPressed: createNewHabit),
      body: ListView.builder(
        itemCount: db.habitList.length,
        itemBuilder: (context,index){
          return HabitTile(
          habitName: db.habitList[index][0],  //primer atributo de cada elemento de la lista
           habitCompleted:db.habitList[index][1],
           onChanged: (value) => checkBoxTapped(value,index),
           settingsClicked: (context) => openHabitSettings(index),
           deleteClicked: (context) => deleteHabit(index) ,

           );
        }
        
        
        )
    );
  }
}