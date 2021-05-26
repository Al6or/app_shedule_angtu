import 'dart:io';

import 'package:angtu_shedule_flutter/models/Chairs.dart';
import 'package:angtu_shedule_flutter/models/Groups.dart';
import 'package:angtu_shedule_flutter/models/Faculties.dart';
import 'package:angtu_shedule_flutter/models/Sesion.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/models/tutorial.dart';
import 'package:http/http.dart' as http;

import '../models/House.dart';

class Services {
  //список факультетов
  //../faculty
  static Future<List<Faculties>> getFaculties() async {
    try {
      const String url = 'https://10.0.2.2:5001/faculty';
      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Faculties> faculties = facultiesFromJson(response.body);
        return faculties;
      } else {
        return <Faculties>[];
      }
    } catch (e) {
      return <Faculties>[];
    }
  }

//список групп
//../faculty_grup/{the_facult}
  static Future<List<Groups>> getGroups(String nameFaculty) async {
    try {
      String url = 'https://10.0.2.2:5001/faculty_grup/$nameFaculty';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Groups> groups = groupsFromJson(response.body);
        return groups;
      } else {
        return <Groups>[];
      }
    } catch (e) {
      return <Groups>[];
    }
  }

  //список групп
  //../cathedra
  static Future<List<Chairs>> getChairs() async {
    try {
      String url = 'https://10.0.2.2:5001/cathedra';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Chairs> chairs = chairsFromJson(response.body);
        return chairs;
      } else {
        return <Chairs>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <Chairs>[] ?? 'Список пуст';
    }
  }

  //список преподавателей по кафедрам
  //../cathedra_people/{the_cathedra}
  static Future<List<Chairs>> getTeacher(String nameTeacher) async {
    try {
      String url = 'https://10.0.2.2:5001/cathedra_people/$nameTeacher';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Chairs> teachers = chairsFromJson(response.body);
        return teachers;
      } else {
        return <Chairs>[];
      }
    } catch (e) {
      return <Chairs>[];
    }
  }

  //большой список расписание группы/(чет/нечет)
  //../academic_plan_grup_week/{the_grup}/{the_weeks}
  static Future<List<Shedule>> getSheduleGroup(
      String nameGroup, bool week) async {
    try {
      String url =
          'https://10.0.2.2:5001/academic_plan_grup_week/$nameGroup/$week';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Shedule> sheduleGroups = sheduleFalseFromJson(response.body);
        return sheduleGroups;
      } else {
        return <Shedule>[] ?? 'список пуст';
      }
    } catch (e) {
      return <Shedule>[] ?? 'ошибка';
    }
  }

  //большой список расписание преподавателя/(чет/нечет)
  //../academic_plan_peopel_week​/{the_peopel}​/{the_weeks}
  static Future<List<Shedule>> getSheduleTeacher(
      String nameTeacher, bool week) async {
    try {
      String url =
          'https://10.0.2.2:5001/academic_plan_peopel_week/$nameTeacher/$week';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Shedule> sheduleTeacher =
            sheduleFalseFromJson(response.body);
        return sheduleTeacher;
      } else {
        print(response.statusCode);
        return <Shedule>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <Shedule>[] ?? 'Список пуст';
    }
  }

  //большой список расписание сесии преподавателя/(чет/нечет)
  //../session_people/{the_people}
  static Future<List<Sesion>> getSesionTeacher(String nameTeacher) async {
    try {
      String url = 'https://10.0.2.2:5001/session_people/$nameTeacher';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Sesion> sesionTeacher = sesionFromJson(response.body);
        return sesionTeacher;
      } else {
        print(response.statusCode);
        return <Sesion>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <Sesion>[] ?? 'Список пуст';
    }
  }

  //большой список, расписание сесии группы/(чет/нечет)
  //../session_grup/{the_grup}
  static Future<List<Sesion>> getSesionGroup(String nameGroup) async {
    try {
      String url = 'https://10.0.2.2:5001/session_grup/$nameGroup';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Sesion> sesionTeacher = sesionFromJson(response.body);
        return sesionTeacher;
      } else {
        print(response.statusCode);
        return <Sesion>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <Sesion>[] ?? 'Список пуст';
    }
  }

  //большой список, консультаций
  //..​/consultations_сathedra/{the_сathedra}/{the_weeks}
  static Future<List<Tutorial>> getTutorial(String nameChair, bool week) async {
    try {
      String url =
          'https://10.0.2.2:5001/consultations_сathedra/$nameChair/$week';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<Tutorial> tutorial = tutorialFromJson(response.body);
        return tutorial;
      } else {
        print(response.statusCode);
        return <Tutorial>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <Tutorial>[] ?? 'Список пуст';
    }
  }

  //большой список список корпусов
  //..​//corpus_inf
  static Future<List<House>> getHouse() async {
    try {
      String url = 'https://10.0.2.2:5001/corpus_inf';

      final response =
          await http.get(Uri.parse(url), headers: {'ApiKey': 'MeSexretkey'});
      if (200 == response.statusCode) {
        final List<House> tutorial = houseFromJson(response.body);
        return tutorial;
      } else {
        print(response.statusCode);
        return <House>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <House>[] ?? 'Список пуст';
    }
  }
}
