//список факультетов
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Faculties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListFaculty extends StatefulWidget {
  @override
  _ListFacultyState createState() => _ListFacultyState();
}

class _ListFacultyState extends State<ListFaculty> {
  String returnNameValue;
  List<Faculties> _faculties;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getFaculties().then((faculties) {
      setState(() {
        _faculties = faculties;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Загрузка...' : 'Факультеты'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _faculties ? 0 : _faculties.length,
          itemBuilder: (context, index) {
            Faculties faculties = _faculties[index];
            return ListTile(
                title: Text(faculties.theFaculty),
                leading: Icon(Icons.label),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  setState(() {
                    returnNameValue = faculties.theFaculty;
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
