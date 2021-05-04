import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Group.dart';
import 'package:angtu_shedule_flutter/models/UserTest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String fcValue = 'выбрать факультет';
  String gpValue = 'выбрать группу';
  //состояние при запуске
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Значение fcValue загрузки при запуске
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fcValue = prefs.getString('fcValue') ?? 'выбрать факультет';
    });
  }

  //сохранение значение fcValue
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('fcValue', fcValue);
    });
  }

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
              trailing: Text(fcValue),
              onTap: () {
                _awaitReturnValueListFaculty(context);
              },
            ),
            ListTile(
              title: Text("Группы "),
              trailing: Text(gpValue),
              onTap: () {
                _awaitReturnValueListGroup(context);
              },
            ),
            ElevatedButton(
              child: Text('Сохранить'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                _incrementCounter();
              },
            )
          ],
        ));
  }

//выбранный факультет
  void _awaitReturnValueListFaculty(BuildContext context) async {
    // запускаем ListFaculty и ждем, пока он вернеться с результатом
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListFaculty(),
        ));
    // после того, как вернется результат ListFaculty, обновит текстовый виджет с ним
    setState(() {
      fcValue = result ?? 'выбрать факультет';
    });
  }

  //выбранный факультет
  void _awaitReturnValueListGroup(BuildContext context) async {
    // запускаем ListFaculty и ждем, пока он вернеться с результатом
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListGroup(),
        ));
    // после того, как вернется результат ListFaculty, обновит текстовый виджет с ним
    setState(() {
      gpValue = result ?? 'null';
    });
  }
}

//список факультетов
class ListFaculty extends StatefulWidget {
  @override
  _ListFacultyState createState() => _ListFacultyState();
}

String returnNameValue;

class _ListFacultyState extends State<ListFaculty> {
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
        title: Text(_loading ? 'Загрузка...' : 'Факультеты'),
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
                    returnNameValue = user.name.toString();
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

//список групп
class ListGroup extends StatefulWidget {
  @override
  _ListGroupState createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  String nameVale;
  List<Group> _group;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getGroupId(int.parse(returnNameValue)).then((group) {
      setState(() {
        _group = group;
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
          itemCount: null == _group ? 0 : _group.length,
          itemBuilder: (context, index) {
            Group group = _group[index];
            return ListTile(
                title: Text(group.name),
                subtitle: Text(group.postId.toString()),
                leading: Icon(Icons.label),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    nameVale = group.name;
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
    String textToSendBack = nameVale;
    Navigator.pop(context, textToSendBack);
  }
}