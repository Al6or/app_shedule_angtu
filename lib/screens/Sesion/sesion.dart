import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Sesion.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/Sesion/ContainerSesion.dart';
import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  static const String routeName = "/exam";
  @override
  ExamScreenState createState() => ExamScreenState();
}

class ExamScreenState extends State<ExamScreen> {
  List<Sesion> _list = [];

  @override
  void initState() {
    super.initState();

    if (SharedPrefs().user == headStudent) {
      //расписание ссесии если группа
      Services.getSesionGroup(SharedPrefs().group).then((group) {
        setState(() {
          _list = group;
        });
      });
    } else {
      //расписание ссесии если преподаватель
      Services.getSesionTeacher(SharedPrefs().teacher).then((teacher) {
        setState(() {
          _list = teacher;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сессия'),
        backgroundColor: Color(0xff153f65),
      ),
      body: SizedBox.expand(
        child: containerDataSesion(_list),
      ),
    );
  }
}
