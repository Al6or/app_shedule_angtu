import 'package:angtu_shedule_flutter/main.dart';
import 'package:flutter/material.dart';

//страница с расписанием экзаменов
//доступна из меню
class ExamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Расписание экзаменов'),
          backgroundColor: Colors.teal[900],
        ), //заголовок всей страницы
        body: BodyMain(), //Главная страница
        drawer: new DrawerOnly(),
      ),
    );
  }
}
