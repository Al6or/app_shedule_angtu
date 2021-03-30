import 'package:angtu_shedule_flutter/exam_page.dart';
import 'package:angtu_shedule_flutter/info_page.dart';
import 'package:angtu_shedule_flutter/settings_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(HeadPage());

//Страница с расписание семестра
//доступна их меню
class HeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Расписание семестра'),
          backgroundColor: Colors.teal[900],
        ), //заголовок всей страницы
        body: BodyMain(), //Главная страница
        drawer: new DrawerOnly(),
      ),
    );
  }
}

//меню слева
class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              accountName: Text('Меню'),
              accountEmail:
                  Text('Преподователь/Студент'), //ИЗМЕНИТЬ ДАННЫЕ ИЗ ФАЙЛА
              decoration: BoxDecoration(color: Colors.teal),
            ),
          ),
          new ListTile(
            title: new Text("Семестр"), //заголовок
            leading: Icon(Icons.event_note), //иконки
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new HeadPage()));
            },
          ), //плитка листа семестр
          new ListTile(
            title: new Text("Экзамены"),
            leading: Icon(Icons.assignment_late),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ExamPage()));
            },
          ), //плитка листа экзамены
          new ListTile(
            title: new Text("Информация"),
            leading: Icon(Icons.info),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new InfoPage()));
            },
          ), //плитка листа инф. универ
          new ListTile(
            title: new Text("Настройки"),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SettingPage()));
            },
          ), //плитка листа настройки
        ],
      ),
    ); //меню слева
  }
}

//главная страница
class BodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
