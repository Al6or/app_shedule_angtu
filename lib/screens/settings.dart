import 'package:angtu_shedule_flutter/list/ListChair.dart';
import 'package:angtu_shedule_flutter/list/ListFaculty.dart';
import 'package:angtu_shedule_flutter/list/ListGroup.dart';
import 'package:angtu_shedule_flutter/list/ListTeacher.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'home.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String facultyValue = SharedPrefs().fackulty;
  String groupValue = SharedPrefs().group;
  String chairValue = SharedPrefs().chair;
  String teacherValue = SharedPrefs().teacher;

  String headName;
  String textName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Настройки"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Факультет: "),
              trailing: Text(facultyValue),
              onTap: () {
                _awaitReturnValueListFaculty(context);
              },
            ),
            ListTile(
              title: Text("Группа: "),
              trailing: Text(groupValue),
              onTap: () {
                _awaitReturnValueListGroup(context);
              },
            ),
            ListTile(
              title: Text("Кафедра: "),
              trailing: Text(chairValue),
              onTap: () {
                _awaitReturnValueListChair(context);
              },
            ),
            ElevatedButton(
              child: Text('Продолжить'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                if (SharedPrefs().group == 'выбрать группу') {
                  headName = 'Нужно выбрать группу!';
                  textName = 'Группы можно отфильтровать по факультетам';
                } else {
                  /* if (SharedPrefs().teacher == 'выбрать преподавателя') {
                    headName = 'Нужно выбрать преподавателя!';
                    textName = 'Преподавателей можно отфильтровать по кафедрам';
                  } else {*/
                  headName = null;
                  textName = null;
                  // pop - закрыть
                  Navigator.of(context).pop();
                  // pushNamed -  перейти к маршруту
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                  //}
                }
                //если переменные не пустые выводить всплывающие окно
                if (headName.isNotEmpty && textName.isNotEmpty) {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(headName),
                        content: Text(textName),
                        actions: <Widget>[
                          TextButton(
                            child: Text('ОК'),
                            onPressed: () {
                              // pop - закрыть
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
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
      facultyValue = result ?? 'выбрать факультет';
      groupValue = 'выбрать группу';
      SharedPrefs().fackulty = facultyValue; //сохранение значение локально
    });
  }

  //выбранная группа
  void _awaitReturnValueListGroup(BuildContext context) async {
    // запускаем ListFaculty и ждем, пока он вернеться с результатом
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListGroup(),
        ));
    // после того, как вернется результат ListFaculty, обновит текстовый виджет с ним
    setState(() {
      groupValue = result ?? 'выбрать группу';
      SharedPrefs().group = groupValue; //сохранение значение локально
    });
  }

  //выбранная кафедра
  void _awaitReturnValueListChair(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListChair(),
        ));
    setState(() {
      chairValue = result ?? 'выбрать кафедру';
      teacherValue = 'выбрать преподавателя';
      SharedPrefs().chair = chairValue; //сохранение значение локально
    });
  }

  //выбрать преподавателя
  void _awaitReturnValueListTeacher(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListTeacher(),
        ));
    setState(() {
      teacherValue = result ?? 'выбрать преподавателя';
      SharedPrefs().teacher = teacherValue; //сохранение значение локально
    });
  }
}
