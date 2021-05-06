import 'package:flutter/material.dart';

class ExamScreen extends StatelessWidget {
  static const String routeName = "/exam";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Информация об АнГТУ"),
      ),
      body: Container(
          child: Center(
        child: Text("Экран информация"),
      )),
    );
  }
}
