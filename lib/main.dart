import 'dart:io';
import 'package:angtu_shedule_flutter/screens/StartScreens/SplashScreen.dart';
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

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff153f65), //appbar Very dark blue
          fontFamily: 'JostMedium',
          textTheme: TextTheme(
              // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              // bodyText2: TextStyle(fontSize: 20),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
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
