import 'package:angtu_shedule_flutter/main.dart';
import 'package:flutter/material.dart';

//страница с листом идет вместо календаря
class ListShedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(''),
          backgroundColor: Colors.teal[900],
        ), //заголовок всей страницы
        body: BodyMain(), //Главная страница
        drawer: new DrawerOnly(),
      ),
    );
  }
}
