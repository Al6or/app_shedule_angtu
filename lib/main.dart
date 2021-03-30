import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:angtu_shedule_flutter/screens/settings.dart';
import 'package:angtu_shedule_flutter/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(), // маршрут главная страница "home" - неявно '/'
    routes: <String, WidgetBuilder>{
      // определить маршруты
      SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
      InfoScreen.routeName: (BuildContext context) => InfoScreen(),
      ExamScreen.routeName: (BuildContext context) => ExamScreen(),
    },
  ));
}
