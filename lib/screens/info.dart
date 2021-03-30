import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  static const String routeName = "/info";

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
