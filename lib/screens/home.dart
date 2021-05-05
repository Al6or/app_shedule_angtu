import 'package:angtu_shedule_flutter/screens/exam.dart';
import 'package:angtu_shedule_flutter/screens/info.dart';
import 'package:flutter/material.dart';
import 'package:angtu_shedule_flutter/screens/settings.dart';

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
        accountEmail: Text('Преподователь/Студент'), //ИЗМЕНИТЬ ДАННЫЕ ИЗ ФАЙЛА
        decoration: BoxDecoration(color: Colors.teal),
      ),
    );
    //всплывающие окно с информацией
    var aboutChild = AboutListTile(
        child: Text("About"),
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
      getNavItem(Icons.info, "Информация об АнГТУ", InfoScreen.routeName),
      getNavItem(Icons.settings, "Настройки", SettingsScreen.routeName),
      getNavItem(Icons.assignment_late, "Экзамен", ExamScreen.routeName),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  //главная страница
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Расписание"),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
          child: Center(
        child: Text("Домашняя страница"),
      )),
      // Установите панель навигации
      drawer: getNavDrawer(context),
    );
  }
}
