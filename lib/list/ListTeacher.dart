//список преподавателей
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Teachers.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
  String returnNameValue;
  List<Teachers> _teacher;
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
        backgroundColor: Color(0xff153f65),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _teacher ? 0 : _teacher.length,
          itemBuilder: (context, index) {
            Teachers teacher = _teacher[index];
            return ListTile(
                title: Text(teacher.theTeacher),
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
                    returnNameValue = teacher.theTeacher;
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