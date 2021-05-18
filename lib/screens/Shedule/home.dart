import 'dart:io';

import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/calendarEvenOdd.dart';
import 'package:angtu_shedule_flutter/screens/Sesion/sesion.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/Informations/info.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/introSettings.dart';
import 'package:angtu_shedule_flutter/screens/Tutorial/tutorial.dart';
import 'package:angtu_shedule_flutter/screens/Shedule/ContainerShedule.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  HomeScreenState createState() => HomeScreenState();
}

//Подзаголовок в меню
String whoYou() {
  String who = SharedPrefs().user;
  if (SharedPrefs().user == headStudent) {
    who += " " + SharedPrefs().group;
  } else {
    who += " " + SharedPrefs().teacher;
  }
  return who;
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
        accountName: Text(
          'Меню',
          style: TextStyle(fontSize: 20),
        ),
        accountEmail: Text(
          whoYou(),
          style: TextStyle(fontSize: 15),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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
      ),
    );
    //всплывающие окно с информацией
    var aboutChild = AboutListTile(
        child: Text("Данные о приложение"),
        applicationName: "Расписание АнГТУ\n30.03.2021 \nv1.0.0",
        applicationVersion:
            "REST API:\nЯкимов Артем Вадимович\nПриложение:\nБорисова Александра Евгеньевна",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.topic));
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

//кнопка сменить пользователя
    var userChild = ListTile(
      leading: Icon(Icons.sync_rounded),
      title: Text('Сменить пользователя'),
      onTap: () {
        setState(() {
          SharedPrefs().fackulty = selectFaculty;
          SharedPrefs().chair = selectChair;
          SharedPrefs().group = selectGroup;
          SharedPrefs().dateStart = selectDate;
          SharedPrefs().teacher = selectTeacher;
          SharedPrefs().routeNameSetting = '';
          SharedPrefs().user = selectUser;
          // pop - закрыть выдвижное меню
          Navigator.of(context).pop();
          // pushNamed -  перейти к маршруту
          Navigator.of(context).pushNamed(IntroSettingScreen.routeName);
        });
      },
    );
    //кнопка выйти
    var exitChild = ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Выйти'),
      onTap: () {
        setState(() {
          exit(0);
        });
      },
    );

    //пункты меню
    var myNavChildren = [
      headerChild,
      getNavItem(Icons.wysiwyg_outlined, headSemestr, HomeScreen.routeName),
      getNavItem(Icons.today, headSesia, ExamScreen.routeName),
      getNavItem(Icons.today, headTutorial, ListChairForTutorial.routeName),
      getNavItem(Icons.info, "Информация о унивирситете", InfoScreen.routeName),
      aboutChild,
      getNavItem(Icons.settings, "Настройки", SharedPrefs().routeNameSetting),
      userChild,
      exitChild,
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

//главная страница
  int _currentIndex = nowNumberWeek();
  PageController _pageController;

  List<Shedule> _listFalse = [];
  List<Shedule> _listTrue = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: nowNumberWeek());

    if (SharedPrefs().user == headStudent) {
      //расписание если группа
      //четная неделя
      Services.getSheduleGroup(SharedPrefs().group, false).then((group) {
        setState(() {
          _listFalse = group;
        });
      });
      //Нечетная неделя
      Services.getSheduleGroup(SharedPrefs().group, true).then((group) {
        setState(() {
          _listTrue = group;
        });
      });
    } else {
      //расписание если преподаватель
      //четная неделя
      Services.getSheduleTeacher(SharedPrefs().teacher, false).then((teacher) {
        setState(() {
          _listFalse = teacher;
        });
      });
      //Нечетная неделя
      Services.getSheduleTeacher(SharedPrefs().teacher, true).then((teacher) {
        setState(() {
          _listTrue = teacher;
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
        title: Text(headShedule),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Окрывается календарь',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CalendarEvenOddScreen()),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            containerData(_listFalse),
            containerData(_listTrue),
          ],
        ),
      ),
      // Меню
      drawer: getNavDrawer(context),
      //навигатор нижний
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff153f65),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(
            () => _currentIndex = index,
          );
          _pageController.jumpToPage(index);
        },
        mainAxisAlignment: MainAxisAlignment.center,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Чётная'),
              icon: Icon(Icons.home),
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text('Нечётная'),
              icon: Icon(Icons.apps),
              activeColor: Color(0xffc0c0c0)),
        ],
      ),
    );
  }
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
