//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:habitcheck/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    );
  }
}
    