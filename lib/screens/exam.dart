import 'package:flutter/material.dart';

class ExamScreen extends StatelessWidget {
  static const String routeName = "/exam";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Экзамены"),
      ),
      body: Container(
          child: Center(
        child: Text("Расписание экзаменов"),
      )),
    );
  }
}
