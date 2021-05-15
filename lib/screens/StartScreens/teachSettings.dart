import 'dart:ui';

import 'package:angtu_shedule_flutter/list/ListChair.dart';
import 'package:angtu_shedule_flutter/list/ListTeacher.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/Shedule/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeachSettingScreen extends StatefulWidget {
  static const String routeName = "/teacher";
  @override
  IntroSettingScreenState createState() => IntroSettingScreenState();
}

class IntroSettingScreenState extends State<TeachSettingScreen> {
  String chairValue = SharedPrefs().chair;
  String teacherValue = SharedPrefs().teacher;

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        SharedPrefs().dateStart = DateFormat('dd.MM.yyyy').format(currentDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff153f65),
          title: Text("Настройки"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg7.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: ListView(children: <Widget>[
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(
                        Icons.auto_stories,
                        color: Color(0xff153f65),
                      ),
                      title: Text(headChair),
                      subtitle: Text(chairValue),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Color(0xff153f65),
                      ),
                      onTap: () {
                        _awaitReturnValueListChair(context);
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(
                        Icons.person_rounded,
                        color: Color(0xff153f65),
                      ),
                      title: Text(headTeacher),
                      subtitle: Text(teacherValue),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Color(0xff153f65),
                      ),
                      onTap: () {
                        _awaitReturnValueListTeacher(context);
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(
                        Icons.group,
                        color: Color(0xff153f65),
                      ),
                      title: Text(headDate),
                      subtitle: Text(SharedPrefs().dateStart),
                      trailing: Icon(
                        Icons.arrow_right,
                        color: Color(0xff153f65),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  Card(
                    color: Color(0xff153f65),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        "продолжить",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        _btNext(context);
                      },
                    ),
                  ),
                ]))));
  }

  //выбранная кафедра
  void _awaitReturnValueListChair(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListChair(),
        ));
    setState(() {
      chairValue = result ?? selectChair;
      teacherValue = selectTeacher;
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
      teacherValue = result ?? selectTeacher;
      SharedPrefs().teacher = teacherValue; //сохранение значение локально
    });
  }
}

void _btNext(BuildContext context) async {
  String headName;
  if (SharedPrefs().teacher == selectTeacher) {
    headName = 'Нужно выбрать преподавателя!';
  } else {
    headName = null;
    // pop - закрыть
    Navigator.of(context).pop();
    // pushNamed -  перейти к маршруту
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
  //если переменные не пустые выводить всплывающие окно
  if (headName.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        action: SnackBarAction(
          label: 'ок',
          textColor: Color(0xff1085c9),
          onPressed: () {},
        ),
        content: Text(headName),
        duration: const Duration(milliseconds: 1500),
        width: 300, //Ширина
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
