import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Sesion.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/widget/ContainerData.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  static const String routeName = "/exam";
  @override
  ExamScreentate createState() => ExamScreentate();
}

class ExamScreentate extends State<ExamScreen> {
//главная страница
  PageController _pageController;

  List<Sesion> _listFalse = [];
  List<Sesion> _listTrue = [];
  bool _loading;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _loading = true;
    if (SharedPrefs().user == headStudent) {
      //расписание если группа
      //четная неделя
      /*  Services.getSheduleGroup(SharedPrefs().group, false).then((group) {
        setState(() {
          _listFalse = group;
          _loading = false;
        });
      });
      //Нечетная неделя
      Services.getSheduleGroup(SharedPrefs().group, true).then((group) {
        setState(() {
          _listTrue = group;
          _loading = false;
        });
      });*/
    } else {
      //расписание если преподаватель
      //четная неделя
      Services.getSesionTeacher(SharedPrefs().teacher).then((teacher) {
        setState(() {
          _listFalse = teacher;
          _loading = false;
        });
      });
      //Нечетная неделя
      Services.getSesionTeacher(SharedPrefs().teacher).then((teacher) {
        setState(() {
          _listTrue = teacher;
          _loading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ссесия'),
        backgroundColor: Color(0xff153f65),
      ),
      body: SizedBox.expand(
        child: containerSesion(_listFalse),
      ),
    );
  }
}
