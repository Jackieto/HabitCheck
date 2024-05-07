//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:habitcheck/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()  async{

  //inicializar hive
 await Hive.initFlutter();
  
  //open box
  await Hive.openBox("Habit_Database");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
    