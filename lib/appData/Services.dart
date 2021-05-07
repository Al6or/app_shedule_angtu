import 'package:angtu_shedule_flutter/models/Chairs.dart';
import 'package:angtu_shedule_flutter/models/Groups.dart';
import 'package:angtu_shedule_flutter/models/Faculties.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/models/Teachers.dart';
import 'package:http/http.dart' as http;

class Services {
  //список факультетов
  //../faculty
  static Future<List<Faculties>> getFaculties() async {
    const String url = 'https://10.0.2.2:5001/faculty';
    try {
      final response = await http.get(Uri.parse(url));
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
    String url = 'https://10.0.2.2:5001/faculty_grup/$nameFaculty';
    try {
      final response = await http.get(Uri.parse(url));
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
    String url = 'https://10.0.2.2:5001/cathedra';
    try {
      final response = await http.get(Uri.parse(url));
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
  static Future<List<Teachers>> getTeacher(String nameTeacher) async {
    String url = 'https://10.0.2.2:5001/cathedra_people/$nameTeacher';
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<Teachers> teachers = teachersFromJson(response.body);
        return teachers;
      } else {
        return <Teachers>[];
      }
    } catch (e) {
      return <Teachers>[];
    }
  }

  //большой список расписание группы/(чет/нечет)
  //../academic_plan_grup_week/{the_grup}/{the_weeks}
  static Future<List<SheduleFalse>> getShedule(
      String nameGroup, bool week) async {
    String url =
        'https://10.0.2.2:5001/academic_plan_grup_week/$nameGroup/$week';
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<SheduleFalse> chairs = sheduleFalseFromJson(response.body);
        return chairs;
      } else {
        return <SheduleFalse>[] ?? 'Список пуст';
      }
    } catch (e) {
      return <SheduleFalse>[] ?? 'Список пуст';
    }
  }
}
