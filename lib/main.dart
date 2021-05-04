import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:angtu_shedule_flutter/screens/settings.dart';
import 'package:angtu_shedule_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs.getString(fcValue) ?? "";

  set username(String value) {
    _sharedPrefs.setString(fcValue, value);
  }
}

bool _loadFackulty() {
  bool n = false;
  if (SharedPrefs().username != 'выбрать факультет') {
    n = true;
  }
  return n;
}

// constants/strings.dart
const String fcValue = "fcValue";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: _loadFackulty()
        ? HomeScreen()
        : SettingsScreen(), // маршрут главная страница "home" - неявно '/'
    routes: <String, WidgetBuilder>{
      // определить маршруты
      SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
      InfoScreen.routeName: (BuildContext context) => InfoScreen(),
      ExamScreen.routeName: (BuildContext context) => ExamScreen(),
    },
  ));
}
