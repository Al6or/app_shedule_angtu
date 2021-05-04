import 'package:angtu_shedule_flutter/models/Group.dart';
import 'package:angtu_shedule_flutter/models/UserTest.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String url = 'http://jsonplaceholder.typicode.com/users';
  static Future<List<Users>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final List<Users> users = usersFromJson(response.body);
        return users;
      } else {
        return <Users>[];
      }
    } catch (e) {
      return <Users>[];
    }
  }

  static Future<List<Group>> getGroupId(int k) async {
    String urlGp = 'https://jsonplaceholder.typicode.com/posts/$k/comments';
    try {
      final response = await http.get(Uri.parse(urlGp));
      if (200 == response.statusCode) {
        final List<Group> group = groupFromJson(response.body);
        return group;
      } else {
        return <Group>[];
      }
    } catch (e) {
      return <Group>[];
    }
  }

  static Future<List<Group>> getExam(int k) async {
    String urlGp = 'https://jsonplaceholder.typicode.com/posts/$k/comments';
    try {
      final response = await http.get(Uri.parse(urlGp));
      if (200 == response.statusCode) {
        final List<Group> group = groupFromJson(response.body);
        return group;
      } else {
        return <Group>[];
      }
    } catch (e) {
      return <Group>[];
    }
  }
}
