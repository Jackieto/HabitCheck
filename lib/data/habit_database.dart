
import 'package:habitcheck/date/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';
//referenciar caja


final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List habitList = [];
  Map<DateTime,int> heatMapDataSet = {};

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

    //calcular porcentaje de habitos completados
    calculatePercentages();
    
  

    //cargar heatmap
    loadHeatMap();

  }

  

  void calculatePercentages(){
    int countCompleted = 0;
    for(int i = 0; i < habitList.length; i++){
      if(habitList[i][1] == true){
        countCompleted++;
      }
    }

    String percent = habitList.isEmpty
      ? '0.0'
      :(countCompleted / habitList.length).toStringAsFixed(1);

      _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}",percent);
  }

  void loadHeatMap(){
     DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}