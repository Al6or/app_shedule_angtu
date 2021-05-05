import 'dart:io';

import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:angtu_shedule_flutter/screens/settings.dart';
import 'package:angtu_shedule_flutter/screens/home.dart';
import 'package:flutter/material.dart';

bool _loadGroup() {
  bool n = false;
  if (SharedPrefs().group != 'выбрать группу') {
    n = true;
  }
  return n;
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _loadGroup() ? HomeScreen() : SettingsScreen(),
    routes: <String, WidgetBuilder>{
      // определить маршруты
      SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
      InfoScreen.routeName: (BuildContext context) => InfoScreen(),
      ExamScreen.routeName: (BuildContext context) => ExamScreen(),
      HomeScreen.routeName: (BuildContext context) => HomeScreen(),
    },
  ));
}
