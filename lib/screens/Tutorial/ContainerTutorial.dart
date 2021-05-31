//загружаются данные Сессия для преподователя
import 'package:angtu_shedule_flutter/models/tutorial.dart';
import 'package:angtu_shedule_flutter/screens/Shedule/ContainerShedule.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

Widget containerTutorial(List<Tutorial> listShedule) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/720.png'), fit: BoxFit.cover)),
    child: GroupedListView<Tutorial, String>(
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
              title: Text(element.thePeople),
              trailing: Text(element.theCorpus + "\n" + element.theAudience),
            ),
          ),
        );
      },
    ),
  );
}
