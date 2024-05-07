
import 'package:habitcheck/date/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';
//referenciar caja


final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List habitList = [];

  //crear datos iniciales por defecto
  void createDefaultData(){

    habitList = [
      ["Leer libro", false],
      ["Tocar guitarra", false],

    ];

  _myBox.put("START_DATE", todaysDateFormatted());
  }

  //cargar datos si ya existen
  void loadData(){

    //si es un nuevo dia, cargar habitos de la base de datos

     if(_myBox.get(todaysDateFormatted()) == null){
        habitList = _myBox.get("CURRENT_HABIT_LIST");

      //si es un nuevo día, poner todas las checkboxes en falso
      for(int i = 0; i < habitList.length; i++){
        habitList[i][1] = false;
      }

     }

    //si no es un nuevo dia, cargar los habitos de ese mismo dia
    else{

      habitList = _myBox.get(todaysDateFormatted());

    }
  }

  //actualizar base de datos
  void updateDatabase(){

    //actualizar habitos diarios
    _myBox.put(todaysDateFormatted(), habitList);



    //actualizar lista de hábitos global

    _myBox.put("CURRENT_HABIT_LIST",habitList);

  }

}