//Группированный список расписание студент
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

Widget containerData(List<Shedule> listShedule) {
  var tu;
  if (SharedPrefs().user == headStudent) {
    tu = containerGroup(listShedule);
  } else {
    tu = containerTeacher(listShedule);
  }
  return tu;
}

//загружаются данные расписание по группам
Widget containerGroup(List<Shedule> listShedule) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.1, 0.5, 0.8, 1],
        colors: [
          Color(0xff03131f),
          Color(0xff153f65),
          Color(0xff1085c9),
          Color(0xff153f65),
          Color(0xff03131f),
        ],
      ),
    ),
    child: GroupedListView<Shedule, String>(
      elements: listShedule,
      groupBy: (element) => element.theDaysWeek,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item2, item1) => item1.theTime.compareTo(item2.theTime),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          numberInText(value),
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

//загружаются данные расписания по преподавателя

Widget containerTeacher(List<Shedule> listShedule) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.1, 0.5, 0.8, 1],
        colors: [
          Color(0xff03131f),
          Color(0xff153f65),
          Color(0xff1085c9),
          Color(0xff153f65),
          Color(0xff03131f),
        ],
      ),
    ),
    child: GroupedListView<Shedule, String>(
      elements: listShedule,
      groupBy: (element) => element.theDaysWeek,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item2, item1) => item1.theTime.compareTo(item2.theTime),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          numberInText(value),
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
