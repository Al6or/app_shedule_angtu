import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

Widget containerData(List<Shedule> listShedule) {
  var tu;
  if (SharedPrefs().user == headStudent) {
    tu = _containerGroup(listShedule);
  } else {
    tu = _containerTeacher(listShedule);
  }
  return tu;
}

//загружаются данные расписание по группам
Widget _containerGroup(List<Shedule> listShedule) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/720.png'), fit: BoxFit.cover)),
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
                element.theTime + "\n" + _theEndTime(element.theTime),
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

//окончание пары
String _theEndTime(String theEndTime) {
  if (isDate(theEndTime)) {
    //если не время пустое поле
    theEndTime = DateFormat('HH:mm').format(DateFormat('HH:mm')
        .parse(theEndTime)
        .add(Duration(hours: 1, minutes: 30)));
  } else {
    theEndTime = '';
  }
  return theEndTime;
}

//проверить ялвяется ли строка датой
bool isDate(String str) {
  try {
    DateFormat('HH:mm').parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

//загружаются данные расписания по преподавателя

Widget _containerTeacher(List<Shedule> listShedule) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/720.png'), fit: BoxFit.cover)),
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
                element.theTime + "\n" + _theEndTime(element.theTime),
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

//функция для замены цифр на слова
String numberInText(String value) {
  switch (int.parse(value)) {
    case 1:
      value = 'Понедельник';
      break;
    case 2:
      value = 'Вторник';
      break;
    case 3:
      value = 'Среда';
      break;
    case 4:
      value = 'Четверг';
      break;
    case 5:
      value = 'Пятница';
      break;
    case 6:
      value = 'Суббота';
      break;
    case 7:
      value = 'Воскресенье';
      break;
  }
  return value;
}
