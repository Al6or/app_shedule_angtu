import 'package:angtu_shedule_flutter/models/Sesion.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

String _dateParseMy(String value) {
  return DateFormat('dd MMMM', 'ru_RU')
      .format(DateFormat('MM.dd.yyyy', 'ru_RU').parse(value));
}

Widget containerDataSesion(List<Sesion> listShedule) {
  var tu;
  if (SharedPrefs().user == headStudent) {
    tu = _containerSesionStudent(listShedule);
  } else {
    tu = _containerSesionTeacher(listShedule);
  }
  return tu;
}

//загружаются данные Сессия для преподователя
Widget _containerSesionTeacher(List<Sesion> listShedule) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/720.png'), fit: BoxFit.cover)),
    child: GroupedListView<Sesion, String>(
      elements: listShedule,
      groupBy: (element) => DateFormat('MM.dd.yyyy')
          .format(DateFormat('dd MMMM', 'ru_RU').parse(element.theDate)),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item2, item1) => item1.theTime.compareTo(item2.theTime),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _dateParseMy(value),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
              leading: Text(
                element.theTime,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(element.theDiscipline),
              subtitle:
                  Text(element.theTypeExperience + " " + element.theGrups),
              trailing: Text(element.theCorpus + "\n" + element.theAudience),
            ),
          ),
        );
      },
    ),
  );
}

//загружаются данные Сессия для студента
Widget _containerSesionStudent(List<Sesion> listShedule) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/720.png'), fit: BoxFit.cover)),
    child: GroupedListView<Sesion, String>(
      elements: listShedule,
      groupBy: (element) => DateFormat('MM.dd.yyyy')
          .format(DateFormat('dd MMMM', 'ru_RU').parse(element.theDate)),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item2, item1) => item1.theTime.compareTo(item2.theTime),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _dateParseMy(value),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
              leading: Text(
                element.theTime,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(element.theDiscipline),
              subtitle: Text(
                  element.theTypeExperience + " " + element.theAboutTheTeacher),
              trailing: Text(element.theCorpus + "\n" + element.theAudience),
            ),
          ),
        );
      },
    ),
  );
}
