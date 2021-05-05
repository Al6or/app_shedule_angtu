//список преподавателей
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Groups.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTeacher extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacher> {
  String returnNameValue;
  List<Groups> _group;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getGroups(SharedPrefs().fackulty).then((group) {
      setState(() {
        _group = group;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Загрузка...' : 'Группы'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _group ? 0 : _group.length,
          itemBuilder: (context, index) {
            Groups group = _group[index];
            return ListTile(
                title: Text(group.theGrups),
                leading: Icon(Icons.label),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    returnNameValue = group.theGrups;
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
