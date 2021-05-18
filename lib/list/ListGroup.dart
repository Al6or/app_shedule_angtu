//список групп
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Groups.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListGroup extends StatefulWidget {
  @override
  _ListGroupState createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
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
        title: Text(_loading ? valueLoad : selectGroup),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _group ? 0 : _group.length,
          itemBuilder: (context, index) {
            Groups group = _group[index];
            return ListTile(
                title: Text(group.theGrups),
                leading: Icon(
                  Icons.people_alt,
                  color: Color(0xff153f65),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Color(0xff153f65),
                ),
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
