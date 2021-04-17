import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/UserTest.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String nameFaculty = 'Text'; //ДОЛЖЕН ГРУЗИТЬСЯ ИЗ БД

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Настройки"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Факультеты "),
              trailing: Text(nameFaculty),
              onTap: () {
                _awaitReturnValueListFaculty(context);
              },
            ),
          ],
        ));
  }

//выбранный факультет
  void _awaitReturnValueListFaculty(BuildContext context) async {
    // запускаем ListFaculty и ждем, пока он закончит с результатом
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListFaculty(),
        ));
    // после того, как вернется результат ListFaculty, обновите текстовый виджет с ним
    setState(() {
      nameFaculty = result ?? 'null';
    });
  }
}

//список факультетов
class ListFaculty extends StatefulWidget {
  @override
  _ListFacultyState createState() => _ListFacultyState();
}

class _ListFacultyState extends State<ListFaculty> {
  String returnNameValue;

  List<Users> _users;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Загрузка...' : 'Пользователи'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _users ? 0 : _users.length,
          itemBuilder: (context, index) {
            Users user = _users[index];
            return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                leading: Icon(Icons.label),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    returnNameValue = user.name;
                    _sendDataBack(context);
                  });
                });
          },
        ),
      ),
    );
  }

  //возвращаемое значение (факультет)
  void _sendDataBack(BuildContext context) {
    String textToSendBack = returnNameValue;
    Navigator.pop(context, textToSendBack);
  }
}
