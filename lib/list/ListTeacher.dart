//список преподавателей
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Chairs.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
  String returnNameValue;
  List<Chairs> _teacher;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getTeacher(SharedPrefs().chair).then((teacher) {
      setState(() {
        _teacher = teacher;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? valueLoad : selectTeacher),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _teacher ? 0 : _teacher.length,
          itemBuilder: (context, index) {
            Chairs teacher = _teacher[index];
            return ListTile(
                title: Text(teacher.thePeople),
                leading: Icon(
                  Icons.person,
                  color: Color(0xff153f65),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Color(0xff153f65),
                ),
                onTap: () {
                  setState(() {
                    returnNameValue = teacher.thePeople;
                    _sendDataBack(context);
                  });
                });
          },
        ),
      ),
    );
  }

  //возвращаемое значение (факультет)
  void _sendDataBack(BuildContext context) {
    String textToSendBack = returnNameValue;
    Navigator.pop(context, textToSendBack);
  }
}
