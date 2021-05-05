import 'package:angtu_shedule_flutter/models/m_Group.dart';
import 'package:angtu_shedule_flutter/models/m_Faculties.dart';
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
//..faculty_grup/{the_facult}
  static Future<List<Groups>> getGroup(String nameGroup) async {
    String url = 'https://10.0.2.2:5001/faculty_grup/$nameGroup';
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
}
