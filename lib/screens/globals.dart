library my_prj.globals;

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

//глобальные переменные
String nameFaculty = "yrf";

const String fcValue = "fcValue";

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get fackulty => _sharedPrefs.getString(fcValue) ?? "";

  set fackulty(String value) {
    _sharedPrefs.setString(fcValue, value);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
