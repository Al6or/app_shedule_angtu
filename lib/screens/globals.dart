library my_prj.globals;

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

//глобальные переменные
String headTeacher = "Преподаватель";
String headStudent = "Студент";
String headGroup = "Группа";
String headChair = "Кафедра";
String headFaculty = "Факультет";
String headShedule = "Расписание";
String headDate = "Начала семестра";

String selectTeacher = "Выбрать преподавателя";
String selectGroup = "Выбрать группу";
String selectChair = "Выбрать кафедру";
String selectFaculty = "Выбрать факультет";
String selectUser = "Выбрать пользователя";
String selectDate = "Выбрать дату";

String valueLoad = "Загрузка...";

//переменне в которых хранятся локальные данные
const String facultyValue = "facultyValue";
const String groupValue = "groupValue";
const String chairValue = "chairValue";
const String teacherValue = "teacherValue";
const String userValue = "userValue";
const String dateValue = "dateValue";
const String routeSettingValue = "routeSettingValue";

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  //Чтение/запись факультет
  String get fackulty => _sharedPrefs.getString(facultyValue) ?? selectFaculty;

  set fackulty(String value) {
    _sharedPrefs.setString(facultyValue, value);
  }

  //Чтение/запись группа
  String get group => _sharedPrefs.getString(groupValue) ?? selectGroup;

  set group(String value) {
    _sharedPrefs.setString(groupValue, value);
  }

  //Чтение/запись кафедра
  String get chair => _sharedPrefs.getString(chairValue) ?? selectChair;

  set chair(String value) {
    _sharedPrefs.setString(chairValue, value);
  }

  //Чтение/запись преподаватель
  String get teacher => _sharedPrefs.getString(teacherValue) ?? selectTeacher;

  set teacher(String value) {
    _sharedPrefs.setString(teacherValue, value);
  }

  //Чтение/запись пользователь
  String get user => _sharedPrefs.getString(userValue) ?? selectUser;

  set user(String value) {
    _sharedPrefs.setString(userValue, value);
  }

  //Чтение/запись дата начала семестра
  String get dateStart => _sharedPrefs.getString(dateValue) ?? selectDate;

  set dateStart(String value) {
    _sharedPrefs.setString(dateValue, value);
  }

  //Чтение/запись маршрут для настроек
  String get routeNameSetting =>
      _sharedPrefs.getString(routeSettingValue) ?? '';

  set routeNameSetting(String value) {
    _sharedPrefs.setString(routeSettingValue, value);
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
