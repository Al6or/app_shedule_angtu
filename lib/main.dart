import 'dart:io';

import 'package:angtu_shedule_flutter/screens/CalendarEvenOdd.dart';
import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:angtu_shedule_flutter/screens/introScreens/introSettings.dart';
import 'package:angtu_shedule_flutter/screens/introScreens/studSettings.dart';
import 'package:angtu_shedule_flutter/screens/introScreens/teachSettings.dart';
import 'package:angtu_shedule_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

bool _load() {
  bool n = false;
  if (SharedPrefs().group != selectGroup &&
      SharedPrefs().user != selectUser &&
      SharedPrefs().teacher != selectTeacher) {
    n = true;
  }
  return n;
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _load() ? HomeScreen() : IntroSettingScreen(),
        routes: <String, WidgetBuilder>{
          // определить маршруты
          InfoScreen.routeName: (BuildContext context) => InfoScreen(),
          ExamScreen.routeName: (BuildContext context) => ExamScreen(),
          HomeScreen.routeName: (BuildContext context) => HomeScreen(),
          IntroSettingScreen.routeName: (BuildContext context) =>
              IntroSettingScreen(),
          StudSettingScreen.routeName: (BuildContext context) =>
              StudSettingScreen(),
          TeachSettingScreen.routeName: (BuildContext context) =>
              TeachSettingScreen(),
          CalendarEvenOddScreen.routeName: (BuildContext context) =>
              CalendarEvenOddScreen(),
        },
      )));
}
