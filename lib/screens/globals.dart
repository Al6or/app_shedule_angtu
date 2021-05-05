library my_prj.globals;

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

//глобальные переменные
String nameGlobal = "пока что пусть будет";

//переменная в которой хранится значение факультета
const String facultyValue = "facultyValue";
const String groupValue = "groupValue";
const String chairValue = "chairValue";
const String teacherValue = "teacherValue";

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  //Чтение/запись факультет
  String get fackulty =>
      _sharedPrefs.getString(facultyValue) ?? 'выбрать факультет';

  set fackulty(String value) {
    _sharedPrefs.setString(facultyValue, value);
  }

  //Чтение/запись группа
  String get group => _sharedPrefs.getString(groupValue) ?? 'выбрать группу';

  set group(String value) {
    _sharedPrefs.setString(groupValue, value);
  }

  //Чтение/запись кафедра
  String get chair => _sharedPrefs.getString(chairValue) ?? 'выбрать кафедру';

  set chair(String value) {
    _sharedPrefs.setString(chairValue, value);
  }

  //Чтение/запись преподаватель
  String get teacher =>
      _sharedPrefs.getString(teacherValue) ?? 'выбрать преподавателя';

  set teacher(String value) {
    _sharedPrefs.setString(teacherValue, value);
  }
}

//разрешены все сертификаты
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
