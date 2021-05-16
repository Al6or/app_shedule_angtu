import 'dart:io';
import 'package:angtu_shedule_flutter/screens/calendarEvenOdd.dart';
import 'package:angtu_shedule_flutter/screens/Sesion/sesion.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/Informations/info.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/introSettings.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/studSettings.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/teachSettings.dart';
import 'package:angtu_shedule_flutter/screens/Shedule/home.dart';
import 'package:angtu_shedule_flutter/screens/Tutorial/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

bool _load() {
  bool n = false;
  if (SharedPrefs().user != selectUser &&
      (SharedPrefs().teacher != selectTeacher ||
          SharedPrefs().group != selectGroup)) {
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
          ListChairForTutorial.routeName: (BuildContext context) =>
              ListChairForTutorial(),
        },
      )));
}
