import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:angtu_shedule_flutter/screens/settings.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:week_of_year/week_of_year.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  //выдвижное меню слева
  Drawer getNavDrawer(BuildContext context) {
    //заголовок выдвижного меню
    var headerChild = DrawerHeader(
      //убираем границы
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: UserAccountsDrawerHeader(
        accountName: Text('Меню'),
        accountEmail: Text('Группа: ' + SharedPrefs().group),
        decoration: BoxDecoration(color: Colors.teal),
      ),
    );
    //всплывающие окно с информацией
    var aboutChild = AboutListTile(
        child: Text("о программе"),
        applicationName: "Расписание АнГТУ\n30.03.2021",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));
    //навигация меню
    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop - закрыть выдвижное меню
            Navigator.of(context).pop();
            // pushNamed -  перейти к маршруту
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    //пункты меню
    var myNavChildren = [
      headerChild,
      getNavItem(Icons.home, "Домашняя страница", HomeScreen.routeName),
      getNavItem(Icons.assignment_late, "Экзамен", ExamScreen.routeName),
      getNavItem(Icons.info, "Информация об АнГТУ", InfoScreen.routeName),
      getNavItem(Icons.settings, "Настройки", SettingsScreen.routeName),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

//главная страница
  int _currentIndex = nowNumberWeek();
  PageController _pageController;

  List<SheduleFalse> _groupFalse = [];
  List<SheduleFalse> _groupTrue = [];
  bool _loading;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: nowNumberWeek());

    _loading = true;
    Services.getShedule(SharedPrefs().group, false).then((group) {
      setState(() {
        _groupFalse = group;
        _loading = false;
      });
    });
    Services.getShedule(SharedPrefs().group, true).then((group) {
      setState(() {
        _groupTrue = group;
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var test = 'Назад';
    return Scaffold(
      appBar: AppBar(title: Text("Расписание")),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            //четная неделя
            Container(
              child: GroupedListView<SheduleFalse, String>(
                elements: _groupFalse,
                groupBy: (element) => element.theDaysWeek,
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1.theDiscipline.compareTo(item2.theDiscipline),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    numberInText(value),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                itemBuilder: (c, element) {
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(Icons.accessible),
                        title: Text(element.theDiscipline),
                        subtitle: Text(element.theCorpus +
                            " " +
                            element.theTime +
                            " " +
                            element.theAudience +
                            "\n" +
                            element.theTypeExperience +
                            " " +
                            element.theAboutTheTeacher),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    ),
                  );
                },
              ),
            ),
            //Нечетная неделя
            Container(
              child: GroupedListView<SheduleFalse, String>(
                elements: _groupTrue,
                groupBy: (element) => element.theDaysWeek,
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1.theDiscipline.compareTo(item2.theDiscipline),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    numberInText(value),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                itemBuilder: (c, element) {
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(Icons.accessible),
                        title: Text(element.theDiscipline),
                        subtitle: Text(element.theCorpus +
                            " " +
                            element.theTime +
                            " " +
                            element.theAudience +
                            "\n" +
                            element.theTypeExperience +
                            " " +
                            element.theAboutTheTeacher),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Меню
      drawer: getNavDrawer(context),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Чётная'), icon: Icon(Icons.home)),
          BottomNavyBarItem(title: Text('Нечётная'), icon: Icon(Icons.apps)),
        ],
      ),
    );
  }
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

//функция для вычисления четной/нечетной недели
int nowNumberWeek() {
  int i;
  final date = DateTime.now();
  if (date.weekOfYear % 2 == 0) {
    i = 0;
  } else {
    i = 1;
  }
  return i;
}
