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
}
