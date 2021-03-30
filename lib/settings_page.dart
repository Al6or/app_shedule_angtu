import 'package:angtu_shedule_flutter/main.dart';
import 'package:flutter/material.dart';

//РАБОТА С ФАЙЛОМ
//страница настройки
//доступна из меню
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Настройки'),
          backgroundColor: Colors.teal[900],
        ), //заголовок всей страницы
        body: BodyMain(), //Главная страница
        drawer: new DrawerOnly(),
      ),
    );
  }
}
